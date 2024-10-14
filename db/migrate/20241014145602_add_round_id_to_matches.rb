class AddRoundIdToMatches < ActiveRecord::Migration[7.0]
  def up
    # Crear un Round por defecto
    default_round = Round.create!

    # Agregar la columna round_id a la tabla matches
    add_reference :matches, :round, null: true, foreign_key: true

    # Asignar el round_id del Round por defecto a todos los Match existentes
    Match.update_all(round_id: default_round.id)

    # Cambiar la columna round_id para que no permita valores nulos
    change_column_null :matches, :round_id, false
  end

  def down
    # Eliminar la columna round_id de la tabla matches
    remove_reference :matches, :round, foreign_key: true
  end
end
