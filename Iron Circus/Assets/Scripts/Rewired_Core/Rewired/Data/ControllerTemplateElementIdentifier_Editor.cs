using System;
using Rewired;
using UnityEngine;

namespace Rewired.Data
{
	[Serializable]
	internal class ControllerTemplateElementIdentifier_Editor : ControllerTemplateElementIdentifier
	{
		[SerializeField]
		private string _scriptingName;
		[SerializeField]
		private string _alternateScriptingName;
		[SerializeField]
		private bool _excludeFromExport;
		[SerializeField]
		private bool _useEditorElementTypeOverride;
		[SerializeField]
		private ControllerElementType _editorElementTypeOverride;
	}
}
