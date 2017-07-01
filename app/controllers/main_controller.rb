require 'open-uri'
class MainController < ApplicationController
	def index
		generate_dupes
	end

	def api
		render :json => generate_dupes
	end

	private
		def generate_dupes
			website_to_parse = open('https://www.viki.com/')
			@doc = Nokogiri::HTML(website_to_parse)
			total_combined_array = []
			@obj = {}
			sections = ['trending', 'viki_picks', 'fan_collections', 'carousel', 'coming_soon', 'on_air']
			
			trending_css_class = "[data-block-track='popular'] .card .thumbnail-wrapper a"
			viki_picks_css_class = "[data-block-track='vikiCollections'] .section h3 a"
			fan_collections_css_class = "[data-block-track='fanCollections'] .section h3 a"
			carousel_css_class = ".carousel-container .item .carousel-play-action"
			coming_soon_css_class = "[data-block-track='upcomingChannelList'] .thumbnail .thumbnail-wrapper a"
			on_air_css_class = "[data-block-track='onAirChannelList'] .dropdown-toggle ul a"

			trending_entries = @doc.css(trending_css_class).take(6)
			viki_picks_entries = @doc.css(viki_picks_css_class)
			fan_collections_entries = @doc.css(fan_collections_css_class)		
			carousel_entries = @doc.css(carousel_css_class)
			coming_soon_entries = @doc.css(coming_soon_css_class)
			on_air_entries = @doc.css(on_air_css_class)

			[	trending_entries,
				viki_picks_entries,
				fan_collections_entries,
				carousel_entries,
				coming_soon_entries,
				on_air_entries
			].each_with_index do |one, index| 
				@obj[sections[index]] = get_link(one)
				total_combined_array += get_link(one)
			end
			@duplicates = create_hash_table(total_combined_array)
			{
				:trending_entries => trending_entries,
				:viki_picks_entries => viki_picks_entries,
				:fan_collections_entries => fan_collections_entries,
				:carousel_entries => carousel_entries,
				:coming_soon_entries => coming_soon_entries,
				:on_air_entries => on_air_entries,
				:duplicates => @duplicates
			}
		end

		def create_hash_table(list)
			h = Hash.new
			duplicates = []
			list.each do |entry|
				if h.key?(entry)
					duplicates << entry
				else 
					h[entry] = 1
				end
			end	
			return duplicates
		end
	
		def get_link(collections_entries) 
			@combined_array = []		
			collections_entries.each do |entry|
				link = entry['href']
				@combined_array << link
			end
			return @combined_array
		end
end
