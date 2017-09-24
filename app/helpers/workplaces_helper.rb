module WorkplacesHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_workplaces_path
    elsif action_name == 'edit'
      workplace_path
    end
  end
end
