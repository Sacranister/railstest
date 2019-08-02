module Fancy
	def createfancy
		@fancifier = MakeFancy.new(@post.title)
		@fancifier.palindrome
	end

	class MakeFancy

		def initialize(fancy)
			@title = fancy
		end
		def palindrome
			@title+@title.reverse
		end
	end

end
