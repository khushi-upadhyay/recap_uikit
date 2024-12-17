//
//  ArticleDataModels.swift
//  recap
//
//  Created by Diptayan Jash on 05/11/24.
//

import Foundation
struct Article: Identifiable, Equatable {
    let id = UUID()
    let image: String
    let title: String
    let subtitle: String
    let content: String
}


let sampleArticles = [
    Article(image: "article", title: "Activities for Alzheimer's", subtitle: "Spending time with a family member or friend in the middle or late stages ...", content: """
        Alzheimer's disease can create challenges in maintaining mental and physical well-being. However, spending quality time with a family member or friend can significantly help improve mood and cognitive function. Activities like memory games, puzzle solving, gardening, and even simple walks in nature can stimulate the brain and promote better communication.

        It's important to tailor activities to the individual's ability level, ensuring they are engaging yet not overwhelming. Creating a consistent routine with enjoyable tasks can provide structure and a sense of accomplishment.

        Some beneficial activities include:
        - **Memory Matching Games:** These can help enhance memory recall.
        - **Art and Music Therapy:** Engaging in creative outlets can improve cognitive function and emotional well-being.
        - **Exercise and Movement:** Simple stretches or yoga can enhance mobility and overall physical health.

        By being present and patient, caregivers can offer great support in fostering a positive environment for those with Alzheimer's.
    """),
    
    Article(image: "article", title: "Cognitive Exercises", subtitle: "Engaging in mental activities that promote brain health ...", content: """
        Cognitive exercises are designed to stimulate the brain and improve its ability to process information, recall memories, and perform tasks more efficiently. Engaging in mental activities can delay cognitive decline, boost problem-solving abilities, and improve mood.

        Some cognitive exercises that benefit brain health include:
        - **Puzzles and Brain Teasers:** These are great for sharpening memory and logic.
        - **Memory Games:** Playing games that require recalling information can help maintain long-term memory.
        - **Reading and Learning New Skills:** Continuously challenging the brain with new information promotes cognitive resilience.
        - **Crossword and Sudoku Puzzles:** These games help strengthen problem-solving and reasoning abilities.

        Research suggests that regular engagement in cognitive exercises can enhance the plasticity of the brain, making it more adaptable to changes over time.
    """),
    
    Article(image: "article", title: "Caregiver Stress", subtitle: "The demands of caregiving can be exhausting and overwhelming ...", content: """
        Being a caregiver for a loved one with a chronic illness or condition like Alzheimer's can be incredibly rewarding but also mentally and physically demanding. Caregivers often face overwhelming stress due to the constant emotional and physical demands placed upon them.

        It's important to recognize the signs of caregiver stress, such as:
        - **Physical Exhaustion:** Constant caregiving without adequate rest can lead to burnout and health problems.
        - **Emotional Strain:** Feelings of frustration, sadness, or guilt are common among caregivers.
        - **Isolation:** Caregivers often neglect their own social needs due to time constraints.

        To manage stress, caregivers should focus on self-care strategies like:
        - **Taking Breaks:** It's essential to schedule regular time off, even if it’s just for a short walk or a moment of relaxation.
        - **Seeking Support:** Whether it’s from family, friends, or professional support groups, talking to others can reduce the feeling of isolation.
        - **Setting Realistic Expectations:** Acknowledge that it's okay to ask for help and not do everything alone.

        Recognizing caregiver stress early and taking steps to reduce it is key to ensuring that both the caregiver and the person they care for can thrive.
    """)
]

