namespace SteelCircus.Utils.Smoothing
{
	public class HarmonicMotionValueBase<T>
	{
		public bool recalcCoefficientsEveryStep;
		public T targetValue;
		public T velocity;
		public T currentValue;
	}
}
