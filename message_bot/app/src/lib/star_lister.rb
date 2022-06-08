require 'mechanize'

class StarLister
  def initialize
    @agent = Mechanize.new
  end

  def list_2434
    page = @agent.get('https://wikiwiki.jp/nijisanji/Apex%20Legends%E3%81%BE%E3%81%A8%E3%82%81/%E3%83%97%E3%83%AC%E3%82%A4%E3%83%A4%E3%83%BCID%E3%81%BE%E3%81%A8%E3%82%81')
    page.css('div#content table tbody tr').map do |v|
      [v.css(':nth-child(2)').text, v.at_css(':nth-child(1) a').text]
    end
  end
end
