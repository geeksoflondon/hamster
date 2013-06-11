class FixingDietToInt < ActiveRecord::Migration
  def up
    add_column :attendees, :diet_temp, :integer

    Attendee.reset_column_information
    Attendee.all.each do |attendee|
      attendee.diet_temp = attendee.diet.to_i
      attendee.save(:without_protection => true)
    end

    remove_column :attendees, :diet
    rename_column :attendees, :diet_temp, :diet
  end

  def down    
    add_column :attendees, :diet_temp, :text
    
    Attendee.all.each do |attendee|
      attendee.diet_temp = attendee.diet.to_s
      attendee.save
    end

    remove_column :attendees, :diet
    rename_column :attendees, :diet_temp, :diet
  end
end
