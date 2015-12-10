module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "Ticketee").join(" - ")
      end
    end
  end

  def admins_only(&block)
    # Use try here instead of current_user.admin? since if the client is not
    # logged in the current_user will return nil thereby raising NoMethodError,
    # which is not desired.
    block.call if current_user.try(:admin?)
  end

  def roles
    roles_hash = {}
    Role.available_roles.each do |role|
      roles_hash[role.titleize] = role
    end
    roles_hash
  end
end
