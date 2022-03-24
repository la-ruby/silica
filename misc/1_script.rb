

class Experiment
  include SendGrid

  def experiment
    Rails.logger.info "testing"     

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    # params = JSON.parse('{
    #   "page_size": 100
    # }')
    params = {}
    
    response = sg.client.marketing.lists.get(query_params: params)
    Rails.logger.info response.status_code
    Rails.logger.info response.headers
    Rails.logger.info response.body
    $aaa = response.body

  end
end

# Development notes:
# $ be rails c
# irb> load './misc/1_script.rb'; Experiment.new.experiment

