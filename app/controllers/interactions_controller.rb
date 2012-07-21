class InteractionsController < ApiController
  before_filter :stringify_value

  private

  def stringify_value
    if params["interaction"] && !params["interaction"]["value"].nil?
      params["interaction"]["value"] = params["interaction"]["value"].to_s
    end
  end
end
