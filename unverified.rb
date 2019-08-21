#!/usr/bin/env ruby

require 'nokogiri'
require 'haml'
require 'htmlbeautifier'

locations = {}
header = nil
remaining = 0
ARGV.each do |file|
  doc = File.open(file) { |f| Nokogiri::HTML(f) }
  if header.nil?
    header = doc.css('table.play-detail-set > tr').first.to_s
  end
  # doc.css('td.play-title-header').first.text
  doc.css('tr > td > span.unverified-symbol').each do |unverified|
    tr = unverified.parent.parent
    tr.css('a').each do |link|
      link['href'] = 'https://shakespearecensus.org' + link['data-form']
    end
    location = tr.css('td')[1].text.strip
    locations[location] ||= []
    locations[location] << tr.to_s
    remaining += 1
  end
end

template = IO.read(File.join('index.haml'))
haml_engine = Haml::Engine.new(template, :format => :html5)
open('index.html','w') {|file|
  file.write(HtmlBeautifier.beautify(haml_engine.render(Object.new, :header => header, :locations => locations, :remaining => remaining)))
}
