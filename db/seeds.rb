# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
User.reset_sequence!

Blog.delete_all
Blog.reset_sequence!

Category.delete_all
Category.reset_sequence!

Article.delete_all
Article.reset_sequence!

Picture.delete_all
Picture.reset_sequence!

article_content = %{
<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p><br />
<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.</p>
<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p><br /><p>
It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p><br /><p>
There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>
}

ARTICLE_IMG_PATH = Rails.application.config.assets.paths[0]+"/orange1x1.png"
ARTICLE_IMG = File.open(ARTICLE_IMG_PATH)

BLOG_IMG_PATH = Rails.application.config.assets.paths[0]+"/blue1x1.png"
BLOG_IMG = File.open(BLOG_IMG_PATH)

# administrative user
User.create(name: "mimin", email: "mimin@41studio.com", password: "paketelor2", password_confirmation: "paketelor2")

momod = User.new(name: "momod", email: "momod@41studio.com", password: "paketelor", password_confirmation: "paketelor")

if momod.save!
	momod.categories.create([{name: "General"}, {name: "Web Development"}, {name: "Ruby on Rails"}, {name: "Javascript"}, {name: "SEO"}])
end

(1..10).each do |num|
	user_name = 'User'+num.to_s
	user = User.new(
		name: user_name,
		email: "#{user_name}@41studio.com",	
		password: "samasemua",
		password_confirmation: "samasemua"
	)
	if user.save! 
		user_blog = user.build_blog(
			name: "#{user_name}'s Blog"
			)

		#blog_img = blog.build_picture(name:)
            
		if user_blog.save!
			('ABCD'..'ABCX').each do |title|
				article_title = "#{title} Article"
				article = user_blog.articles.new(
					title: article_title,
					content: article_content
				)
				
				if article.save!
					article_img = article.pictures.new(name: ARTICLE_IMG)
					article_img.save!
				end
			end 
			
		end
	end
	
end
