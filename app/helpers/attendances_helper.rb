module AttendancesHelper
  def attendance_choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_attendances_path
    elsif action_name == 'edit'
      attendance_path
    end
  end
end
