class CreateWorkType < ActiveRecord::Migration
  def up
    # create_table :work_types do |t|
    #   t.string :name

    #   t.timestamps
    # end

    # ['Roof', 'Gutters', 'Solar', 'Skylights', 'Other'].each do |name|
    #   WorkType.create!(name: name)
    # end
  end

  def down
    drop_table :work_types
  end
end
