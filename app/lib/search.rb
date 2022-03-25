# frozen_string_literal: true

module Search
  # simplified version of what used to be advanced_search
  def search(query: nil,
             sourcefilter: nil,
             statusfilter: nil,
             statefilter: nil,
             cityfilter: nil,
             req_date: nil,
             offer_sent: nil,
             sort_by: nil, sort_direction: nil, page: 1, per: 25)
    rel = Project

    #
    # searching
    #
    rel = rel.where("searchable ILIKE '%#{query}%'") if query.present?
    # /searching

    #
    # filtering
    #
    if sourcefilter.present?
      sources = sourcefilter.split('__')
      rel = rel.where(direction: sources)
    end
    if statusfilter.present?
      statuses = statusfilter.split('__')
      rel = rel.where(status: statuses)
    end
    if statefilter.present?
      states = statefilter.split('__')
      rel = rel.where(state: states)
    end
    if cityfilter.present?
      cities = cityfilter.split('__')
      rel = rel.where(city: cities)
    end
    if req_date.present?
      rel = rel.where(
        'req_date BETWEEN ? AND ?',
        req_date.split(' to ')[0],
        req_date.split(' to ')[1]
      )
    end
    if offer_sent.present?
      rel = rel.where(
        'offer_sent BETWEEN ? AND ?',
        offer_sent.split(' to ')[0],
        offer_sent.split(' to ')[1]
      )
    end
    # /filtering

    #
    # sorting
    #
    rel = rel.order('lower(name) ASC') if sort_by == 'name' && sort_direction == 'asc'
    rel = rel.order('lower(name) DESC') if sort_by == 'name' && sort_direction == 'desc'
    rel = rel.order('street') if sort_by == 'address' && sort_direction == 'asc'
    rel = rel.order('street DESC') if sort_by == 'address' && sort_direction == 'desc'
    rel = rel.order('phone') if sort_by == 'phone' && sort_direction == 'asc'
    rel = rel.order('phone DESC') if sort_by == 'phone' && sort_direction == 'desc'
    rel = rel.order('email') if sort_by == 'email' && sort_direction == 'asc'
    rel = rel.order('email DESC') if sort_by == 'email' && sort_direction == 'desc'
    rel = rel.order('expectedtimeline') if sort_by == 'expectedTimeline' && sort_direction == 'asc'
    rel = rel.order('expectedtimeline DESC') if sort_by == 'expectedTimeline' && sort_direction == 'desc'
    rel = rel.order('req_date') if sort_by == 'req_date' && sort_direction == 'asc'
    rel = rel.order('req_date DESC') if sort_by == 'req_date' && sort_direction == 'desc'
    rel = rel.order('offer_sent') if sort_by == 'offer_sent' && sort_direction == 'asc'
    rel = rel.order('offer_sent DESC') if sort_by == 'offer_sent' && sort_direction == 'desc'
    rel = rel.order('offer_viewed') if sort_by == 'offer_viewed' && sort_direction == 'asc'
    rel = rel.order('offer_viewed DESC') if sort_by == 'offer_viewed' && sort_direction == 'desc'
    rel = rel.order('accepted_at') if sort_by == 'offer_accepted' && sort_direction == 'asc'
    rel = rel.order('accepted_at DESC') if sort_by == 'offer_accepted' && sort_direction == 'desc'
    rel = rel.order('addendum_sent') if sort_by == 'addendum_sent' && sort_direction == 'asc'
    rel = rel.order('addendum_sent DESC') if sort_by == 'addendum_sent' && sort_direction == 'desc'
    rel = rel.order('direction') if sort_by == 'source' && sort_direction == 'asc'
    rel = rel.order('direction DESC') if sort_by == 'source' && sort_direction == 'desc'
    rel = rel.order('lower(status) ASC') if sort_by == 'status' && sort_direction == 'asc'
    rel = rel.order('lower(status) DESC') if sort_by == 'status' && sort_direction == 'desc'

    unless sort_by.present?
      rel = rel.order(
        Arel.sql("(case status when 'Open' then 1 else 2 end)"),
        Arel.sql('created_at DESC')
      )
    end
    # /sorting

    # pagination
    rel.page(page).per(per)
  end
end
