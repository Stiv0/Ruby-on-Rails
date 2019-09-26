Coding Rails
######Kui rails on installitud

$ rails new blog
$ cd blog

#App on see main folder
#public on nähtav

$ rails server
$ rails generate controller Welcome index

#Ava app/views/welcome/index.html.erb, redaktor HTML peale
#Kustuta kõik ja asenda: <h1>Hello, Rails!</h1>
#Ava config/routes.rb ja asenda: 
		Rails.application.routes.draw do
		  get 'welcome/index'
		  resources :articles
		  root 'welcome#index'
		end

$ rails routes

#Tee uued folderid /articles/new
 http://localhost:3000/articles/new

$ rails generate controller Articles

#Ava app/controllers/articles_controller.rb ja lisa: 
		class ArticlesController < ApplicationController
		  def new
		  end
		end

#Tee uus fail at app/views/articles/new.html.erb (Faili extension on rubyOnRails)
#Lisa see sinna faili: 
		<h1>New Article</h1>
#Kontrolli, et töötab ja lisa: (See joonistab esimese formi)
		<%= form_with scope: :article, url: articles_path, local: true do |form| %>
		  <p>
		    <%= form.label :title %><br>
		    <%= form.text_field :title %>
		  </p>
		 
		  <p>
		    <%= form.label :text %><br>
		    <%= form.text_area :text %>
		  </p>
		 
		  <p>
		    <%= form.submit %>
		  </p>
		<% end %>

#Postimine annab errori. Parandame

#Ava app/controllers/articles_controller.rb ja asenda sisu: 
		class ArticlesController < ApplicationController
		  def new
		  end
		 
		  def create
		   render plain: params[:article].inspect
		  end
		end

#Nüüd ta annab meile parameetrid, liigutame need uute modelisse

$ rails generate model Article title:string text:text
$ rails db:migrate

#Ava app/controllers/artivles_controller.rb ja create action selliseks: 
		  @article = Article.new(params[:article])
		 
		  @article.save
		  redirect_to @article

#Controller tahab teada parameetreid, muuda create actionis: 
		@article = Article.new(params.require(:article).permit(:title, :text))

#Lisa samasse faili: 
		private
		  def article_params
		    params.require(:article).permit(:title, :text)
		  end
#Fail peaks selline välja nägema: 
	 class ArticlesController < ApplicationController
	  def new
	  end
	 
	  def create
	  @article = Article.new(params.require(:article).permit(:title, :text))
	 
	  @article.save
	  redirect_to @article
	  end
	  private
		  def article_params
		    params.require(:article).permit(:title, :text)
		  end
	end
#Lisa samasse faili algusesse: 
	 def show
	    @article = Article.find(params[:id])
	  end

#Nüüd loo uus fail: app/views/articles/show.html.erb ja lisa sisu: 
		<p>
		  <strong>Title:</strong>
		  <%= @article.title %>
		</p>
		 
		<p>
		  <strong>Text:</strong>
		  <%= @article.text %>
		</p>

#Nüüd artikklite loomine töötab, localhost:3000/articles/new

#Ava fail app/controllers/articles_controller.rb ja lisa classi algusesse:
		  def index
		    @articles = Article.all
		  end

#Loo uus fail app/views/articles/index.html.erb ja lisa: 
<h1>Listing articles</h1>
		<table>
		  <tr>
		    <th>Title</th>
		    <th>Text</th>
		    <th></th>
		  </tr>
		 
		  <% @articles.each do |article| %>
		    <tr>
		      <td><%= article.title %></td>
		      <td><%= article.text %></td>
		      <td><%= link_to 'Show', article_path(article) %></td>
		    </tr>
		  <% end %>
		</table>

#Nüüd on võimalik vaadata kõiki artikkleid localhost:3000/articles

#Saame ka harcodeida stiili, et oleks natuke arusaadavam, 
		<h1 style = "color: red; justify-content: center;text-align: center;">Listing articles</h1>
		<div style = "display: flex; flex-direction: column; justify-content: center; align-items: center;text-align: center;min-height: 100vh">