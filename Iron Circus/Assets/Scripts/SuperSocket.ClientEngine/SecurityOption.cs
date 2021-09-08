// Decompiled with JetBrains decompiler
// Type: SuperSocket.ClientEngine.SecurityOption
// Assembly: SuperSocket.ClientEngine, Version=0.10.0.0, Culture=neutral, PublicKeyToken=ee9af13f57f00acc
// MVID: D48C73B8-7C95-425B-9116-2817CCFFEC2D
// Assembly location: D:\SteamLibrary\steamapps\common\Steel_Circus\sc_Data\Managed\SuperSocket.ClientEngine.dll

using System.Net;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;

namespace SuperSocket.ClientEngine
{
  public class SecurityOption
  {
    public SslProtocols EnabledSslProtocols { get; set; }

    public X509CertificateCollection Certificates { get; set; }

    public bool AllowUnstrustedCertificate { get; set; }

    public bool AllowNameMismatchCertificate { get; set; }

    public bool AllowCertificateChainErrors { get; set; }

    public NetworkCredential Credential { get; set; }

    public SecurityOption()
      : this(SecurityOption.GetDefaultProtocol(), new X509CertificateCollection())
    {
    }

    public SecurityOption(SslProtocols enabledSslProtocols)
      : this(enabledSslProtocols, new X509CertificateCollection())
    {
    }

    public SecurityOption(SslProtocols enabledSslProtocols, X509Certificate certificate)
      : this(enabledSslProtocols, new X509CertificateCollection(new X509Certificate[1]
      {
        certificate
      }))
    {
    }

    public SecurityOption(SslProtocols enabledSslProtocols, X509CertificateCollection certificates)
    {
      this.EnabledSslProtocols = enabledSslProtocols;
      this.Certificates = certificates;
    }

    public SecurityOption(NetworkCredential credential) => this.Credential = credential;

    private static SslProtocols GetDefaultProtocol() => SslProtocols.Default;
  }
}
