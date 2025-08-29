//
//  SavedRecipiesViewModel.swift
//  BestRecipe
//
//  Created by Administration  on 22/08/25.
//

import Foundation

class SavedRecipesViewModel {
    var recipes: [RecipeDetails] = [] {
        didSet {
            onRecipesUpdated?()
        }
    }

    var onRecipesUpdated: (() -> Void)?

    func loadSavedRecipes() {
        self.recipes = [
            RecipeDetails(
                title: "Spicy Salmon with edamame",
                time: "15:10",
                imageName: "salmon",
                rating: 5.0,
                reviews: 300,
                instructions: ["""
                               Prepare the sauce:
                                 In a small bowl, whisk together soy sauce, honey, sriracha, rice vinegar (or lime), ginger, and garlic.
                               
                               2. Cook the salmon:
                                 Pat the salmon dry and season lightly with salt and pepper.
                                 Heat olive (or sesame) oil in a skillet over medium heat.
                                 Place salmon fillets skin-side down (if skin-on). Cook for about 4–5 minutes per side until cooked through and lightly caramelized.
                               
                               3. Cook the edamame:
                                 While the salmon cooks, bring a small pot of water to a boil.
                                 Add edamame and cook for 3–4 minutes (if frozen, follow package instructions)
                                 Drain and toss with a pinch of salt.
                               """],
                ingredients: [
                    Ingredient(name: "Salmon", quantity: "500g", imageName: "fish"),
                    Ingredient(name: "Edamame", quantity: "300g", imageName: "vegetable"),
                    Ingredient(name: "Vegetable Oil", quantity: "20g", imageName: "oil"),
                    Ingredient(name: "Salt", quantity: "5g", imageName: "salt"),
                    Ingredient(name: "Peppers", quantity: "100g", imageName: "peppers")
                ]
            ),
            RecipeDetails(
                title: "How to make Veggie Cutlets ",
                time: "15:10",
                imageName: "recipe2",
                rating: 5.0,
                reviews: 300,
                instructions: ["""
Prepare the mixture:
    In a mixing bowl, combine mashed potatoes, boiled vegetables, onion, green chilies, ginger-garlic paste, coriander leaves, spices, salt, and 2 tbsp breadcrumbs.
    Mix well until it holds together. Adjust seasoning if needed.

2.    Shape the cutlets:
    Divide the mixture into equal portions.
    Shape each into round or oval patties

3.    Prepare the coating:
    Mix flour and water to form a thin slurry.
    Dip each cutlet into the slurry, then coat with breadcrumbs.

4.    Cook the cutlets:
    Heat oil in a skillet over medium heat.
    Shallow-fry the cutlets until golden brown and crispy on both sides (about 3–4 minutes per side).
    Drain on paper towels.
"""],
                ingredients: [
                    Ingredient(name: "Flour", quantity: "100g", imageName: "potatos"),
                    Ingredient(name: "Vegetable Mix Paste", quantity: "400g", imageName: "bowl"),
                    Ingredient(name: "Vegetable Oil", quantity: "20g", imageName: "oil"),
                    Ingredient(name: "Salt", quantity: "5g", imageName: "salt"),
                    Ingredient(name: "Egg", quantity: "400g", imageName: "cucumber")
                ]
            ),
            RecipeDetails(title: "NYC Ribeye Steak",
                          time: "15:10",
                          imageName: "meat",
                          rating: 4.5,
                          reviews: 489,
                          instructions: ["""
                              Prep the Steaks
                                  Remove steaks from the fridge 30–45 minutes before cooking.
                                  Pat dry with paper towels.
                                  Season generously with salt and black pepper on both sides.

                              2. Sear the Steaks
                                  Heat a heavy skillet (cast iron preferred) over medium-high until smoking hot.
                                  Add the neutral oil.
                                  Place steaks in the pan and sear undisturbed for ~2–3 minutes on one side until a deep crust forms.
                                  Flip and sear the other side for another 2–3 minutes.

                              3. Butter Basting
                                  Lower heat to medium. Add butter, rosemary sprigs, and smashed garlic to the pan.
                                  Tilt the pan slightly and use a spoon to continuously baste the steaks with the melted, aromatic butter for 1–2 minutes.
                              """],
                          ingredients: [
                            Ingredient(name: "NYC Ribeye", quantity: "200g", imageName: "meatcut"),
                            Ingredient(name: "Rosemary", quantity: "10g", imageName: "herb"),
                            Ingredient(name: "Garlic", quantity: "2 cloves", imageName: "garlic"),
                            Ingredient(name: "Salt", quantity: "5g", imageName: "salt")
                          ]
                          ),
        ]
    }
}
