module ApplicationHelper
  
  def error_messages_for(object)
    render(:partial=>"application/error_messages",:locals=>{:object=>object})
  end
  
  
  def status_bar boolean,option={}
    option[:text_true] ||="" 
    option[:text_false] ||= ""
       
    if boolean
      content_tag(:span,option[:text_true],:class=>"status true")
    else
	content_tag(:span,option[:text_false],:class=>"status false")
    end
  end
  
end
