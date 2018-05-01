Sequel.migration do
  change do
    create_table(:quotes) do
      primary_key :id, unique: true
      String :quote, null: false
      String :author, null: false
    end
  end
end
