
Project.order(:id).each do |project|
  puts project.id
  Event.create(
    category: 'project_creation',
    timestamp: project.created_at,
    record_id: project.id,
    record_type: 'Project',
    inventor_id: 2
  )
  sleep 0.2
end


Project.order(:id).each do |project|
  if project.repcs.last.signed_by_company_at.present?
    puts project.id
    Event.create(
      category: 'addition_repc_signed_by_company_at',
      timestamp: Time.parse(project.repcs.last.signed_by_company_at),
      record_id: project.id,
      record_type: 'Project',
      inventor_id: -2)
  end
  sleep 0.2
end

Project.order(:id).each do |project|
  comment = Comment.create(
    record_id: project.id,
    record_type: 'Project',
    inventor_id: 2
  )
  Event.create(
    category: 'project_comment',
    timestamp: comment.created_at,
    record_id: project.id,
    record_type: 'Project',
    secondary_record_id: comment.id,
    secondary_record_type: 'Comment',
    inventor_id: comment.inventor_id
  )
  sleep 0.2
end

