DROP TABLE IF EXISTS favourites;
DROP TABLE IF EXISTS meals;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username TEXT NOT NULL UNIQUE,
    hash TEXT NOT NULL
);

CREATE TABLE meals (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    country TEXT,
    description TEXT,
    ingredients TEXT,
    calories INTEGER,
    fat REAL,
    carbs REAL,
    sodium REAL,
    protein REAL,
    image TEXT
);

CREATE TABLE favourites (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    user_id INTEGER NOT NULL,
    meal_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (meal_id) REFERENCES meals(id),
    UNIQUE(user_id, meal_id)
);

INSERT INTO meals (name, country, description, ingredients, calories, fat, carbs, sodium, protein, image) 
VALUES 
('Chicken Tikka Masala', 'India', 'Roasted marinated chicken pieces in a spiced sauce.', 'Chicken, Yogurt, Spices, Tomato, Cream', 380, 12.0, 14.0, 140.0, 48.0, 'static/images/chicken-tikka-masala.jpg'),
('Greek Salad', 'Greece', 'Fresh vegetable salad with feta and olive oil.', 'Cucumbers, Tomatoes, Feta, Olives, Olive Oil', 210, 15.0, 9.0, 220.0, 7.0, 'static/images/greek-salad.jpg'),
('Tacos al Pastor', 'Mexico', 'Marinated pork tacos with pineapple and cilantro.', 'Pork, Pineapple, Corn Tortillas, Onion, Cilantro', 320, 10.0, 30.0, 150.0, 25.0, 'static/images/tacos-al-pastor.jpg'),
('Sushi', 'Japan', 'Seaweed rice with raw fish and vegetables.', 'Sushi Rice, Nori, Raw Fish, Vegetables, Soy Sauce', 200, 5.0, 28.0, 300.0, 12.0, 'static/images/sushi.jpg'),
('Pad Thai', 'Thailand', 'Stir-fried rice noodles with shrimp and peanuts.', 'Rice Noodles, Shrimp, Eggs, Peanuts, Bean Sprouts, Tamarind Paste', 350, 14.0, 45.0, 400.0, 20.0, 'static/images/pad-thai.jpg'),
('Tom Yum Soup', 'Thailand', 'Hot and sour Thai soup with shrimp.', 'Shrimp, Lemongrass, Kaffir Lime Leaves, Galangal, Chili, Lime Juice', 180, 4.0, 10.0, 320.0, 22.0, 'static/images/tom-yum-soup.jpg'),
('Palak Paneer', 'India', 'Spinach curry with cubed cheese.', 'Spinach, Paneer, Spices, Garlic', 290, 18.0, 12.0, 120.0, 20.0, 'static/images/palak-paneer.jpg'),
('Ghormeh Sabzi', 'Iran', 'A Persian herb stew made with chicken', 'Chicken, Parsley, Cilantro, Chives, Fenugreek, Spinach, Red Kidney Beans, Dried Limes, Olive Oil, Turmeric, Garlic', 280, 8.0, 38.0, 95.0, 15.0, 'static/images/ghormeh-sabzi.jpg'),
('Shirazi Salad', 'Iran', 'Diced cucumber and tomato salad tossed in a vinaigrette.', 'Cucumbers, Tomatoes, Red Onion, Fresh Mint, Extra Virgin Olive Oil, Lime Juice, Black Pepper', 90, 5.0, 10.0, 15.0, 2.0, NULL),
('Dal Tadka', 'India', 'Yellow lentils with turmeric and garlic.', 'Toor Dal, Tomatoes, Garlic, Ginger, Cumin, Mustard Seeds, Avocado Oil, Lemon Juice, Turmeric', 230, 4.5, 36.0, 80.0, 13.0, 'static/images/dal-tadka.jpg'),
('Chana Masala', 'India', 'Chickpeas cooked in a tomato, onion, and warm spice sauce.', 'Chickpeas, Tomatoes, Onions, Garlic, Ginger, Chana Masala Spice Blend, Olive Oil, Lemon Juice, Cilantro', 280, 5.0, 45.0, 110.0, 14.0, 'static/images/chana-masala.jpg'),
('Rajma Masala', 'India', 'Kidney bean curry cooked in tomato gravy.', 'Red Kidney Beans, Tomatoes, Onions, Garlic, Ginger, Cumin, Garam Masala, Olive Oil, Fresh Coriander', 290, 5.0, 48.0, 105.0, 16.0, NULL),
('Greek Briam', 'Greece', 'Roasted vegetables with olive oil.', 'Zucchini, Potatoes, Eggplant, Tomatoes, Red Onion, Olive Oil, Garlic, Oregano, Black Pepper', 210, 9.0, 30.0, 45.0, 5.0, NULL),
('Gigantes Plaki', 'Greece', 'Baked giant white beans in tomato and herb sauce.', 'Lima Beans, Tomatoes, Olive Oil, Garlic, Onions, Parsley, Lemon Juice', 280, 8.0, 42.0, 85.0, 13.0, NULL),
('Ropa Vieja de Pollo', 'Cuba', 'Shredded chicken breast with Capsicums and onions.', 'Chicken Breast, Capsicums, Onions, Garlic, Tomatoes, Olive Oil, Cumin, Lime Juice', 290, 7.0, 12.0, 130.0, 42.0, NULL),
('Chicken Fajitas', 'Mexico', 'Chicken strips with Capsicums and spices.', 'Chicken Breast, Capsicums, Onions, Olive Oil, Lime Juice, Cumin, Chilli Powder, Garlic', 310, 9.0, 14.0, 120.0, 41.0, 'static/images/chicken-fajitas.jpg'),
('Cuban Black Beans', 'Cuba', 'Black beans cooked with onions, garlic, and spices.', 'Black Beans, Onions, Garlic, Olive Oil, Cumin, Bay Leaf, Red Bell Pepper', 250, 4.0, 45.0, 80.0, 15.0, NULL),
('Feijoada', 'Brazil', 'Black bean stew with pork and beef.', 'Black Beans, Pork Shoulder, Beef Chuck, Onions, Garlic, Bay Leaves, Orange Peel', 400, 18.0, 30.0, 150.0, 35.0, 'static/images/feijoada.jpg'),
('Moqueca Baiana', 'Brazil', 'Fish stew with coconut milk and palm oil.', 'White Fish, Coconut Milk, Palm Oil, Tomatoes, Onions, Garlic, Cilantro', 350, 20.0, 12.0, 140.0, 30.0, NULL),
('Ceviche', 'Peru', 'Raw white fish citrus juices.', 'White Fish, Lime Juice, Red Onion, Cilantro, Chili Peppers, Sweet Potato', 190, 2.5, 16.0, 110.0, 26.0, 'static/images/ceviche.jpg'),
('Solterito de Quinua', 'Peru', 'Quinoa salad with vegetables and citrus dressing.', 'Quinoa, Tomatoes, Corn, Red Onion, Olive Oil, Lime Juice, Cilantro', 260, 7.0, 41.0, 40.0, 9.0, 'static/images/solterito-de-quinua.jpg'),
('Poulet Aux Noix', 'Haiti', 'Chicken with raw cashews and Creole spices.', 'Chicken Breast, Raw Cashews, Capsicums, Tomatoes, Garlic, Lime Juice, Olive Oil, Thyme', 360, 14.0, 15.0, 135.0, 43.0, NULL),
('Asopao De Pollo', 'Puerto Rico', 'Chicken and brown rice soup with vegetables.', 'Chicken Breast, Brown Rice, Tomatoes, Capsicums, Garlic, Cilantro, Olive Oil, Oregano', 320, 6.0, 36.0, 140.0, 31.0, NULL),
('Moqueca de Peixe', 'Brazil', 'White fish and bell pepper stew in light coconut milk.', 'White Fish, Capsicums, Tomatoes, Onions, Light Coconut Milk, Lime Juice, Cilantro, Olive Oil', 290, 11.0, 12.0, 125.0, 34.0, NULL),
('Ajiaco Colombiano', 'Colombia', 'Chicken soup with potatoes, corn, and guascas herbs.', 'Chicken Breast, Potatoes, Corn, Guascas, Garlic, Green Onions, Avocado', 310, 6.0, 38.0, 115.0, 28.0, 'static/images/ajiaco-colombiano.jpg'),
('Jerk Chicken', 'Jamaica', 'Grilled chicken in spicy herbs and citrus.', 'Chicken Breast, Allspice, Scotch Bonnet, Garlic, Ginger, Thyme, Lime Juice, Olive Oil', 280, 8.0, 6.0, 130.0, 44.0, 'static/images/jerk-chicken.jpg'),
('Tuscan Ribollita', 'Italy', 'Vegetable and white bean soup and with whole grain bread.', 'Cannellini Beans, Kale, Cabbage, Tomatoes, Carrots, Celery, Whole Grain Bread, Olive Oil', 260, 6.0, 41.0, 140.0, 12.0, NULL),
('Mercimek Çorbası', 'Turkey', 'Red lentil soup with lemon and spices.', 'Red Lentils, Onions, Carrots, Garlic, Cumin, Olive Oil, Lemon Juice, Mint', 220, 4.0, 36.0, 75.0, 13.0, 'static/images/mercimek-corbasi.jpg'),
('Misir Wat', 'Ethiopia', 'Spicy red lentils in berbere spice.', 'Red Lentils, Onions, Garlic, Ginger, Berbere Spice, Olive Oil, Tomato Paste', 240, 5.0, 38.0, 85.0, 14.0, NULL),
('Atakilt Wat', 'Ethiopia', 'Cabbage, carrots, and potatoes with turmeric.', 'Cabbage, Carrots, Potatoes, Onions, Garlic, Ginger, Turmeric, Olive Oil', 170, 4.5, 30.0, 35.0, 4.0, NULL),
('Harira', 'Morocco', 'Lentil and chickpea soup with herbs and lemon.', 'Lentils, Chickpeas, Tomatoes, Celery, Cilantro, Parsley, Ginger, Cinnamon, Lemon Juice', 250, 3.5, 43.0, 110.0, 13.0, NULL),
('Ojja', 'Tunisia', 'Poached eggs in a spicy pepper and tomato sauce.', 'Eggs, Capsicums, Tomatoes, Garlic, Harissa, Caraway, Olive Oil', 230, 14.0, 11.0, 150.0, 15.0, 'static/images/ojja.jpg'),
('Sashimi', 'Japan', 'Sliced raw salmon and tuna served with ginger.', 'Raw Salmon, Raw Tuna, Daikon Radish, Fresh Ginger, Lemon Slice', 210, 7.0, 2.0, 70.0, 34.0, 'static/images/sashimi.jpg'),
('Garlic Bok Choy', 'China', 'Stir-fried bok choy with garlic and sesame oil.', 'Baby Bok Choy, Garlic, Ginger, Sesame Oil, White Pepper', 80, 4.5, 8.0, 65.0, 4.0, 'static/images/bok-choy.jpg'),
('Kung Pao Chicken', 'China', 'Spicy stir-fried chicken with peanuts and vegetables.', 'Chicken Breast, Peanuts, Bell Peppers, Garlic, Ginger, Soy Sauce, Chili Paste', 320, 12.0, 18.0, 150.0, 30.0, 'static/images/kung-pao-chicken.jpg'),
('Gai Pad Krapow', 'Thailand', 'Stir-fried chicken with basil, chili, and garlic.', 'Ground Chicken Breast, Holy Basil, Garlic, Thai Chili, Lime Juice, Sesame Oil', 270, 8.0, 7.0, 140.0, 40.0, 'static/images/gai-pad-krapow.jpg'),
('Larb Gai', 'Thailand', 'Spicy minced chicken salad with lime and herbs.', 'Ground Chicken Breast, Lime Juice, Fish Sauce, Mint, Cilantro, Red Onion, Chili Flakes', 250, 7.0, 5.0, 130.0, 38.0, NULL),
('Gỏi Gà', 'Vietnam', 'Chicken and cabbage salad with lime dressing.', 'Chicken Breast, Cabbage, Carrots, Mint, Cilantro, Lime Juice, Rice Vinegar, Chili', 220, 4.0, 12.0, 110.0, 32.0, NULL),
('Phở Gà', 'Vietnam', 'Chicken noodle soup with herb broth.', 'Chicken Breast, Rice Noodles, Ginger, Star Anise, Cinnamon, Green Onion, Basil, Lime Juice', 330, 4.5, 44.0, 160.0, 29.0, 'static/images/pho-ga.jpg'),
('Bún Chả', 'Vietnam', 'Grilled pork with rice noodles and herbs.', 'Pork, Rice Noodles, Lettuce, Mint, Cilantro, Fish Sauce, Garlic, Chili', 350, 10.0, 40.0, 180.0, 28.0, NULL),
('Parippu', 'Sri Lanka', 'Red lentils cooked in light coconut milk and spices.', 'Red Lentils, Light Coconut Milk, Turmeric, Mustard Seeds, Curry Leaves, Chili, Garlic', 230, 6.0, 34.0, 70.0, 11.0, 'static/images/parippu.jpg'),
('Borani Banjan', 'Afghanistan', 'Eggplant and tomatoes with garlic yogurt.', 'Eggplant, Tomatoes, Garlic, Plain Greek Yogurt, Mint, Olive Oil', 190, 8.0, 22.0, 80.0, 8.0, NULL),
('Lubya', 'Afghanistan', 'Kidney bean stew with tomatoes and garlic.', 'Red Kidney Beans, Tomatoes, Onions, Garlic, Coriander, Cumin, Olive Oil', 260, 4.0, 44.0, 75.0, 14.0, 'static/images/lubya.jpg'),
('Sabzi', 'Afghanistan', 'Spinach and herbs cooked with garlic and citrus.', 'Spinach, Cilantro, Parsley, Green Onions, Garlic, Olive Oil, Lemon Juice', 140, 7.0, 15.0, 90.0, 6.0, NULL),
('Mujadara', 'Lebanon', 'Lentils and brown rice with caramelized onions.', 'Brown Rice, Green Lentils, Onions, Olive Oil, Cumin, Black Pepper', 290, 6.0, 52.0, 50.0, 11.0, NULL),
('Polvo à Lagareiro', 'Portugal', 'Roasted octopus with small potatoes, garlic, and olive oil.', 'Octopus, Potatoes, Garlic, Extra Virgin Olive Oil, Parsley, Black Pepper', 340, 11.0, 28.0, 180.0, 32.0, 'static/images/polvo-a-lagareiro.jpg'),
('Gambas al Ajillo', 'Spain', 'Shrimp in olive oil, garlic, and chili flakes.', 'Shrimp, Garlic, Extra Virgin Olive Oil, Red Chili Flakes, Parsley, Lemon Juice', 220, 11.0, 4.0, 160.0, 26.0, 'static/images/gambas-al-ajillo.jpg'),
('Ratatouille', 'France', 'Vegetables with garlic and fresh herbs.', 'Zucchini, Eggplant, Capsicums, Tomatoes, Garlic, Olive Oil, Thyme', 160, 7.0, 21.0, 35.0, 4.0, 'static/images/ratatouille.jpg'),
('Gado Gado', 'Indonesia', 'Steamed vegetables and tofu with light peanut sauce.', 'Tofu, Bean Sprouts, Green Beans, Cabbage, Peanut Butter, Lime Juice, Garlic, Chili', 290, 14.0, 26.0, 130.0, 17.0, NULL),
('Prebranac', 'Serbia', 'Baked white bean casserole with onions and paprika.', 'White Beans, Onions, Sweet Paprika, Garlic, Bay Leaf, Olive Oil', 270, 5.0, 46.0, 60.0, 13.0, 'static/images/prebranac.jpg'),
('Chicken & Avocado Bowl', 'USA', 'Grilled chicken, quinoa, black beans, and fresh avocado.', 'Chicken Breast, Quinoa, Black Beans, Avocado, Tomatoes, Cilantro, Lime Juice', 380, 12.0, 36.0, 110.0, 36.0, 'static/images/chicken-avocado-bowl.jpg'),
('Sundubu Jjigae', 'Korea', 'Spicy soft tofu stew with seafood and kimchi.', 'Soft Tofu, Shrimp, Kimchi, Garlic, Green Onions, Gochugaru, Sesame Oil', 230, 8.0, 14.0, 190.0, 24.0, 'static/images/sundubu-jjigae.jpg'),
('Sinigang', 'Philippines', 'Sour tamarind soup with shrimp, radish, and leafy greens.', 'Shrimp, Tamarind Broth, Radish, Water Spinach, Tomatoes, Onions, Garlic, Chili', 210, 3.5, 18.0, 140.0, 26.0, NULL),
('Salt & Pepper Squid with Lemon', 'Australia', 'Pan-seared squid seasoned with black pepper, sea salt, and fresh lemon.', 'Squid, Olive Oil, Black Pepper, Garlic, Lemon Juice, Parsley', 220, 7.0, 6.0, 160.0, 31.0, 'static/images/salt-pepper-squid.jpg'),
('Borsch', 'Russia', 'Beetroot and vegetable soup served with Greek yogurt.', 'Beetroot, Cabbage, Carrots, Tomatoes, Garlic, Dill, Non-Fat Greek Yogurt, Lemon Juice', 150, 2.5, 28.0, 85.0, 5.0, 'static/images/borsch.jpg'),
('Shchi', 'Russia', 'Cabbage soup with potatoes and herbs.', 'Cabbage, Potatoes, Carrots, Onions, Garlic, Dill, Parsley, Olive Oil', 140, 3.0, 26.0, 75.0, 4.0, NULL),
('Kerabu Mangga', 'Malaysia', ' green mango salad tossed with herbs, lime, and crushed peanuts.', 'Green Mango, Shallots, Cilantro, Chili, Lime Juice, Crushed Peanuts, Sesame Oil', 180, 8.0, 25.0, 60.0, 4.0, NULL),
('Hariyali (Hara Masala) Chicken', 'Pakistan', 'Green chicken curry cooked in spices, yogurt sauce.', 'Chicken Breast, Cilantro, Mint, Green Chilies, Garlic, Low-Fat Yogurt, Lemon Juice, spices', 230, 9.0, 7.0, 110.0, 30.0, 'static/images/hariyali-chicken.jpg'),
('Palong Shak Bhaji', 'Bangladesh', 'Sautéed leafy green dish mixed with spice and garlic.', 'Fresh Spinach, Mustard Oil, Panch Phoron, Garlic, Onions, Green Chilies, Dried Red Chili, Lime Juice', 85, 5.0, 7.0, 95.0, 3.5, NULL);