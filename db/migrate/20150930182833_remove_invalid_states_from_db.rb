class RemoveInvalidStatesFromDb < ActiveRecord::Migration
  def change
    State.where(abbr: ['DC', 'AA', 'AE', 'AP']).delete_all
  end
end
