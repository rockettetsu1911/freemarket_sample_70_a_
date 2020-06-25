module TagsHelper
  def render_with_tags(explanation)
    explanation.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/tag/#{word.delete("#")}"}.html_safe
  end 
end
