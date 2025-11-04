module ApplicationHelper
  def status_color_class(status)
    case status
    when "done"
      "bg-green-100 text-green-800"
    when "pending"
      "bg-yellow-100 text-yellow-800"
    else
      "bg-gray-100 text-gray-600"
    end
  end
end
