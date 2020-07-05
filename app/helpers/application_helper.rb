module ApplicationHelper
  # svgファイルを使いやすくするためのヘルパーメソッド
  def embedded_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

  def nl2br(str)
    h(str).gsub(/\R/, '<br>')
  end
end
