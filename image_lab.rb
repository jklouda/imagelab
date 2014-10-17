# Require Mr. Dewey's ruby program "image_array.rb" so that we can use it within our program.  It is stored on the same directory as this program.

require "./image_array.rb"

# ask the user to input the file path of the image they would like to manipulate.  Use a while loop to allow the user to modify more than one image.

choice = "yes"

while choice == "yes"

puts "Enter the FILE PATH for the file you would like to manipulate.  This program needs to know where to find your file!!!"

# call the users filepath orig_file

orig_file = gets.chomp

# check to see if the user entered a valid file by using the File.exists? method.  The ! in front basically says that if File.exists is not true than do the action as outlined in the if statement.

if !File.exists?(orig_file)  
	puts "That file does not exist.  Please start over."
	break
end	

# Create an image array of the users file, using Mr. Dewey's program, and store in in the variable img.  As the orig_file is a variable, it doesn't need quotes around it.  This would indicate it is a string.

img = ImageArray.new(orig_file)

# ask the user to choose how they would like to manipulate their image.

puts "Would you like to make your image black and white (enter bw); make a photo negative of your image (enter neg) or create a tint on your image (enter tint)?  If you would like to quit, enter q."

choice = gets.chomp

	if choice == "bw"

# to make the image black and white, we need to modify the entire array of this image, pixel by pixel.  We need to DO something to EACH |row| of our array of arrays.  Then when we get a row we need to DO something to EACH |pixel| in the row.  The .red, .blue and .green are methods that are available for the pixel elements of the array.  By using .red you are accessing the portion of the pixel color.  You can get a gray color by averaging the blue, red and green pixel colors and then putting that average color (variable name pixel_gray) into the .red, .green and .blue of the pixel.  At the end, save the img to a new file for a black and white photo by writing it to a variable new_file.  

		img.each do |row|
 			row.each do |pixel|
				pixel_gray = (pixel.red + pixel.blue + pixel.green)/3
				pixel.red = pixel_gray
				pixel.green = pixel_gray
				pixel.blue = pixel_gray
			end
		end

# to rename the users original file with a modifier, use the method SUB to sub in _bw.jpg for .jpg and call it "new_file"
	
		new_file = orig_file.sub(".jpg", "_bw.jpg")

# create a new file on the user's drive by writing the variable new_file.  

		img.write(new_file)

	elsif choice == "neg" 

# to make a photo negative of the image, you must invert the red, blue and green components by subtracting them from the maximum possible value.  The maximum possible value can be found by using the .max_intensity method on the object img.

		img.each do |row|
			row.each do |pixel|
				pixel.red = img.max_intensity - pixel.red
				pixel.green = img.max_intensity - pixel.green
				pixel.blue = img.max_intensity - pixel.blue
			end
		end

# to rename the users original file with a modifier, use the method SUB to sub in _neg.jpg for .jpg and call it "new_file"

		new_file = orig_file.sub(".jpg", "_neg.jpg")		

# create a new file on the user's drive by writing the variable new_file.

		img.write(new_file)

	elsif choice == "tint"

# ask the user what color they would like to tint their picture and store their choice in the variable tint_color.

		puts "Enter the color you would like to tint your picture: red, blue or green?"
		tint_color = gets.chomp
	
# to tint the image, take the average of all 3 channels and make just one of the colors equal to that average.  Set the other colors to zero.  This will result in either a red, blue or green tint, depending on which color you set to the average. 

		if tint_color == "red"
	
			img.each do |row|
				row.each do |pixel|
					pixel_tint = (pixel.red + pixel.blue + pixel.green)/3
					pixel.red = pixel_tint
					pixel.green = 0
					pixel.blue = 0
				end
			end

			new_file = orig_file.sub(".jpg", "_red.jpg")
	
			img.write(new_file)
	
		elsif tint_color == "blue"
		
			img.each do |row|
                	        row.each do |pixel|
                	                pixel_tint = (pixel.red + pixel.blue + pixel.green)/3
                	                pixel.red = 0
                	                pixel.green = 0
                	                pixel.blue = pixel_tint
               		        end
                	end

                	new_file = orig_file.sub(".jpg", "_blue.jpg")

                	img.write(new_file)

		elsif tint_color == "green"

			img.each do |row|
                        	row.each do |pixel|
                        	        pixel_tint = (pixel.red + pixel.blue + pixel.green)/3
                                	pixel.red = 0
                               	 	pixel.green = pixel_tint
                                	pixel.blue = 0
                        	end
                	end

			new_file = orig_file.sub(".jpg", "_green.jpg")
		
			img.write(new_file)
		
		end

	elsif choice == "q"

		exit

	elsif

		puts "You did not enter a valid choice."

end	

# ask the user if they would like to run the program again.  This will end the while loop if they answer "no" as the while loop only continues when choice = yes.  

puts "Would you like to manipulate another image?  Enter yes or no?"
choice = gets.chomp

end
       
puts "Good-bye!"
