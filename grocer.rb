# Array of Hashes where each Hash represents a movie; however, they should all have a
  # :director_name key. This addition can be done by using the provided
  # movie_with_director_name method

  result = []
  i = 0

  while i < movies_collection.length do
    movie_data = movies_collection[i]
    result << movie_with_director_name(name, movie_data)
    i += 1
  end

  result
end


def gross_per_studio(collection)
  # GOAL: Given an Array of Hashes where each Hash represents a movie,
  # return a Hash that includes the total worldwide_gross of all the movies from
  # each studio.
  # GOAL: Transform NDS'
  #
  # INPUT:
  # * collection: Array of Hashes where each Hash where each Hash represents a movie
  #
  # RETURN:
  #
  # Hash whose keys are the studio names and whose values are the sum
  # total of all the worldwide_gross numbers for every movie in the input Hash
  # * Hash whose keys are the studio names and whose values are the sum
  #   total of all the worldwide_gross numbers for every movie in the input Hash
  result = {}
  i = 0

  while i < collection.length do
    movie = collection[i]

    if !result[movie[:studio]]
      result[movie[:studio]] = movie[:worldwide_gross]
    else
      result[movie[:studio]] += movie[:worldwide_gross]
    end
    i += 1
  end

  result
end

def movies_with_directors_set(source)
@@ -75,7 +99,21 @@ def movies_with_directors_set(source)
  # RETURN:
  #
  # Array of Arrays containing all of a director's movies. Each movie will need
  # to have a :director_name key added to it.
  # to have a :director_name key added to it. You should use the provided
  # do that work in the movies_with_director_key method

  i = 0
  a_o_a_movies_by_dir = []

  while i < source.length do
    dir_info_hash = source[i]
    director_name = dir_info_hash[:name]
    directors_movies = dir_info_hash[:movies]
    a_o_a_movies_by_dir << movies_with_director_key(director_name, directors_movies)
    i += 1
  end

  a_o_a_movies_by_dir
end