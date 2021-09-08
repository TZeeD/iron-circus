// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.SslStreamTcpSession
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System;
using System.IO;
using System.Net;
using System.Net.Security;
using System.Net.Sockets;
using System.Security.Cryptography.X509Certificates;

namespace SuperSocket.ClientEngine
{
  public class SslStreamTcpSession : AuthenticatedStreamTcpSession
  {
    protected override void StartAuthenticatedStream(Socket client)
    {
      SecurityOption security = this.Security;
      if (security == null)
        throw new Exception("securityOption was not configured");
      SslStream sslStream = new SslStream((Stream) new NetworkStream(client), false, new RemoteCertificateValidationCallback(this.ValidateRemoteCertificate));
      sslStream.BeginAuthenticateAsClient(this.HostName, security.Certificates, security.EnabledSslProtocols, false, new AsyncCallback(this.OnAuthenticated), (object) sslStream);
    }

    private void OnAuthenticated(IAsyncResult result)
    {
      if (!(result.AsyncState is SslStream asyncState))
      {
        this.EnsureSocketClosed();
        this.OnError((Exception) new NullReferenceException("Ssl Stream is null OnAuthenticated"));
      }
      else
      {
        try
        {
          asyncState.EndAuthenticateAsClient(result);
        }
        catch (Exception ex)
        {
          this.EnsureSocketClosed();
          this.OnError(ex);
          return;
        }
        this.OnAuthenticatedStreamConnected((AuthenticatedStream) asyncState);
      }
    }

    private bool ValidateRemoteCertificate(
      object sender,
      X509Certificate certificate,
      X509Chain chain,
      SslPolicyErrors sslPolicyErrors)
    {
      RemoteCertificateValidationCallback validationCallback = ServicePointManager.ServerCertificateValidationCallback;
      if (validationCallback != null)
        return validationCallback(sender, certificate, chain, sslPolicyErrors);
      if (sslPolicyErrors == SslPolicyErrors.None)
        return true;
      if (this.Security.AllowNameMismatchCertificate)
        sslPolicyErrors &= ~SslPolicyErrors.RemoteCertificateNameMismatch;
      if (this.Security.AllowCertificateChainErrors)
        sslPolicyErrors &= ~SslPolicyErrors.RemoteCertificateChainErrors;
      if (sslPolicyErrors == SslPolicyErrors.None)
        return true;
      if (!this.Security.AllowUnstrustedCertificate)
      {
        this.OnError(new Exception(sslPolicyErrors.ToString()));
        return false;
      }
      if (sslPolicyErrors != SslPolicyErrors.None && sslPolicyErrors != SslPolicyErrors.RemoteCertificateChainErrors)
      {
        this.OnError(new Exception(sslPolicyErrors.ToString()));
        return false;
      }
      if (chain != null && chain.ChainStatus != null)
      {
        foreach (X509ChainStatus chainStatu in chain.ChainStatus)
        {
          if ((!(certificate.Subject == certificate.Issuer) || chainStatu.Status != X509ChainStatusFlags.UntrustedRoot) && chainStatu.Status != X509ChainStatusFlags.NoError)
          {
            this.OnError(new Exception(sslPolicyErrors.ToString()));
            return false;
          }
        }
      }
      return true;
    }
  }
}
