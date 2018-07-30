class AddCalendarParamsTo<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def self.up
    change_table :<%= table_name %> do |t|
<%= migration_data -%>

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>
    end
    # add_index :<%= table_name %>, :unlock_token,         unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
