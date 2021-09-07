namespace Entitas
{
	public class ReactiveSystem<TEntity>
	{
		protected ReactiveSystem(IContext<TEntity> context)
		{
		}

		protected ReactiveSystem()
		{
			throw new System.NotImplementedException();
		}
	}
}
