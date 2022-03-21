class MboRequest
  attr_reader :token

  def initialize(token:)
    @token = token
  end

  def second_seller_mode?
    @token.length == 33
  end

  def record
    record = Repc.where(mop_token: @token[0..31]).first
    record = AddendumVersion.where(mop_token: @token[0..31]).first unless record
    raise 'Unknown token' unless record
    raise 'Attempt to access voided repc' if record.is_a?(Repc) && record.id != record.project.repcs.last.id
    record
  end

  def project
    record.is_a?(Repc) ? record.project : record.addendum.project
  end

  def can_leave_feedback?
    record.can_leave_feedback?(second_seller_mode?)
  end
end
