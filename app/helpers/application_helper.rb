module ApplicationHelper

  def show_share_buttons
    html = ""
      html << "<div class='share bordercolor'>"
        html << "<div class='addthis_toolbox addthis_default_style'>"
          html << "<a class='addthis_button_facebook_like' fb:like:layout='button_count'></a>"
          html << "<a class='addthis_button_tweet'></a>"
          html << "<a class='addthis_button_pinterest_pinit'></a>"
          html << "<a class='addthis_counter addthis_pill_style'></a>"
        html << "</div>"
        html << "<script type='text/javascript'>var addthis_config = {'data_track_addressbar':true};</script>"
        html << "<script type='text/javascript' src='//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-5129de45024e4e78'></script>"
      html << "</div>"
      html
  end
end