# Some events are not human generated, in that case
# we can assign it to company
class CompanyUser
  def initials
    COMPANY[0].downcase
  end
end
