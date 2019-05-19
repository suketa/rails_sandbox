class HtmlSafeController < ApplicationController
  def index
    str = '<em>This is HTML safe string first part</em><strong>This is HTML safe string second part</strong>'.html_safe
    i = str.index('<strong>')
    @html_safe_str1 = str[0...i]
    @html_safe_str2 = str[i..]
  end
end
