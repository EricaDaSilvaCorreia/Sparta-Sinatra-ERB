class App < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  set :root, File.join(File.dirname(__FILE__), '..')

  set :views, Proc.new { File.join(root, "views")}

  $books = [
    {
      :id => 1,
      :cover => "https://dynamic.indigoimages.ca/books/1785996312.jpg?altimages=false&scaleup=true&maxheight=515&width=380&quality=85&sale=0&lang=en",
      :title => '1984',
      :year => 1949,
      :author => 'GEORGE ORWELL',
      :description => 'Among the seminal texts of the 20th century, Nineteen Eighty-Four is a rare work that grows more haunting as its futuristic purgatory becomes more real.',
    },
    {
      :id => 2,
      :cover => "https://prodimage.images-bn.com/pimages/9780399501487_p0_v3_s550x406.jpg",
      :title => 'Lord of the Flies',
      :year => 1954,
      :author => 'WILLIAM GOLDING',
      :description => "At the dawn of the next world war, a plane crashes on an uncharted island, stranding a group of schoolboys. At first, with no adult supervision, their freedom is something to celebrate; this far from civilization the boys can do anything they want. Anything. They attempt to forge their own society, failing, however, in the face of terror, sin and evil. And as order collapses, as strange howls echo in the night, as terror begins its reign, the hope of adventure seems as far from reality as the hope of being rescued.",
    },
    {
      :id => 3,
      :cover => "https://prodimage.images-bn.com/pimages/2940013038035_p0_v1_s550x406.jpg",
      :title => 'The Murders in the Rue Morgue',
      :year => 1841,
      :author => 'EDGAR ALLAN POE',
      :description => "The Murders in the Rue Morgue is a short story by Edgar Allan Poe published in Graham's Magazine in 1841. It has been recognized as the first modern detective story; Poe referred to it as one of his 'tales of ratiocination'.",
    },
    {
      :id => 4,
      :cover => "https://images.gr-assets.com/books/1388331515l/68838.jpg",
      :title => 'Waking Up Screaming',
      :year => 2003,
      :author => 'H.P. LOVECRAFT',
      :description => "Cool Air–An icy apartment hides secrets no man dares unlock.
      The Case of Charles Dexter Ward–Ward delves into the black arts and resurrects the darkest evil from beyond the grave.
      The Terrible Old Man–The intruders seek a fortune but find only death.
      Herbert West–Reanimator–Mad experiments yield hideous results in this bloodcurdling tale, the inspiration for the cult film Re-Animator.
      The Shadow Over Innsmouth–A small fishing town’s population is obscenely corrupted by a race of fiendish undersea creatures.
      The Lurking Fear–An upstate New York clan degenerates into thunder-crazed mole like creatures with a taste for human flesh.",
    },
    {
      :id => 5,
      :cover => "https://images-na.ssl-images-amazon.com/images/I/51x3libtE4L._SX323_BO1,204,203,200_.jpg",
      :title => 'Fahrenheit 451',
      :year => 1999,
      :author => 'RAY BRADBURY',
      :description => "Guy Montag is a book-burning fireman undergoing a crisis of faith. His wife spends all day with her television 'family', imploring Montag to work harder so that they can afford a fourth TV wall. Their dull, empty life sharply contrasts with that of his next-door neighbour Clarisse, a young girl thrilled by the ideas in books, and more interested in what she can see in the world around her than in the mindless chatter of the tube. When Clarisse disappears mysteriously, Montag is moved to make some changes, and starts hiding books in his home. Eventually, his wife turns him in, and he must answer the call to burn his secret cache of books. After fleeing to avoid arrest, Montag winds up joining an outlaw band of scholars who keep the contents of books in their heads, waiting for the time society will once again need the wisdom of literature",
    }
  ]

  # Index
  get '/Books' do
    @title = "Index Page"
    @books = $books
    erb :'Books/index'
  end

  # New
  get '/Books/new' do

    erb :'Books/new'
  end


  # Show
  get '/Books/:id'do
    id = params[:id].to_i

    @book = $books[id - 1]
    erb :'Books/show'
  end

  # Create
  post '/books' do
    id = $books.length + 1

    newBook ={
      :id => id,
      :title => params[:title],
      :cover => params[:cover],
      :year => params[:year],
      :author => params[:author],
      :description => params[:description]
    }

    $books.push newBook

    redirect '/Books'

  end

  # Update
  put '/Books/:id'do
  id = params[:id].to_i - 1

    book = $books[id]

    book[:title] = params[:title]
    book[:cover] = params[:cover]
    book[:year] = params[:year]
    book[:author] = params[:author]
    book[:description] = params[:description]

    $books[id] = book

    redirect '/Books'

  end

  # Destroy
  delete '/Books/:id'do
  id = params[:id].to_i
  $books.delete_at id

  redirect '/Books'

  end

  # Edit
  get '/Books/:id/edit'do
  id = params[:id].to_i
  @book = $books[id - 1]

  erb :'Books/edit'

  end

end
