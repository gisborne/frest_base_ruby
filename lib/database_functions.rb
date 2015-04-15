require_relative 'functions'
require_relative 'frest'

Frest.declare_function id: '7555139A-FE9A-4B0F-A169-08CC776E14EC',
    name: 'add_db_connection',
    title: 'Add Database Connection',
    to_type: :database_connection,
    arg_types: {
        host:     :string,
        user:     :string,
        password: :string,
        db_name:  :string
    },
    arg_type_lexifications: {
        user:     'User Name',
        db_name:  'Database Name'
    } do

end