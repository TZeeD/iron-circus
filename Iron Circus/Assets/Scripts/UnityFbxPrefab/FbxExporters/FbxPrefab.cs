using UnityEngine;
using System;
using System.Collections.Generic;

namespace FbxExporters
{
	public class FbxPrefab : MonoBehaviour
	{
		[Serializable]
		public struct StringPair
		{
			public string FBXObjectName;
			public string UnityObjectName;
		}

		[SerializeField]
		private string m_fbxHistory;
		[SerializeField]
		private List<FbxPrefab.StringPair> m_nameMapping;
		[SerializeField]
		private GameObject m_fbxModel;
		[SerializeField]
		private bool m_autoUpdate;
	}
}
