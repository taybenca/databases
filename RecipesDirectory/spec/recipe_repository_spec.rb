require 'recipe_repository'

describe RecipeRepository do
    def reset_recipes_table
        seed_sql = File.read('spec/seeds_recipe_directory.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory' })
        connection.exec(seed_sql)
    end

    before(:each) do 
        reset_recipes_table
    end

    it 'return all recipes' do 
      repo = RecipeRepository.new
      recipes = repo.all
      expect(recipes.length).to eq 3
      expect(recipes.first.title).to eq 'Lasagna'
      expect(recipes.last.rating).to eq '2'
    end

    it 'return the recipe with rating 5' do
      repo = RecipeRepository.new
      recipe = repo.find('5')
      expect(recipe.title).to eq 'Lasagna'
      expect(recipe.cooking_time).to eq '23'
    end
end