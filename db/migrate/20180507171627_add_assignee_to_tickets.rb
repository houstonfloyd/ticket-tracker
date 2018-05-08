class AddAssigneeToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :assignee,
    foreign_key: { to_table: :users }
  end
end