# frozen_string_literal: true

module ProjectsHelper
  # The iamge shown in summary partial of backend
  def summary_image_for_backend(project)
    project.kodaks.where(primary: '1').first&.pic&.variant(:small) ||
      project.kodaks.first&.pic&.variant(:small) ||
      silica_neutral_bucket('/mocks/house.png')
  end

  def formatted_owner_occupied(project)
    if project.owner_occupied == 'true'
      'Yes'
    elsif project.owner_occupied == 'false'
      'No'
    else
      '-'
    end
  end

  def direction_icon(direction)
    direction == "Inbound" ? silica_neutral_bucket("/icons/inbound.svg") : silica_neutral_bucket("/icons/outbound.svg")
  end
end
