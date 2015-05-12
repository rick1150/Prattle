//
//  Quote.swift
//  Prattle
//
//  Created by Rick Zemer on 4/30/15.
//  Copyright (c) 2015 blockpuppy. All rights reserved.
//

import Foundation

enum Topic : String {
   	case Ability         = "Ability"
    case Abuse           = "Abuse"
    case Achievement     = "Achievement"
    case Age             = "Age"
    case Anger           = "Anger"
    case Animals         = "Animals "
    case Anniversary     = "Anniversary"
    case Art             = "Art"
    case Attitude        = "Attitude"
    case Beauty          = "Beauty"
    case Beginnings      = "Beginnings"
    case Bible           = "Bible"
    case Birth           = "Birth"
    case Books           = "Books"
    case Boredom         = "Boredom"
    case Bravery         = "Bravery"
    case BreakingUp      = "Breaking Up"
    case Brevity         = "Brevity"
    case BrokenHeart     = "BrokenHeart"
    case Caution         = "Caution"
    case Ceremony        = "Ceremony"
    case Challenge       = "Challenge"
    case Change          = "Change"
    case Character       = "Character"
    case Charity         = "Charity"
    case Children        = "Children"
    case Christmas       = "Christmas"
    case College         = "College"
    case Commitment      = "Commitment"
    case CommonSense     = "CommonSense"
    case Compassion      = "Compassion"
    case Compromise      = "Compromise"
    case Confidence      = "Confidence"
    case Conflict        = "Conflict"
    case Confusion       = "Confusion"
    case Courage         = "Courage"
    case Courtesy        = "Courtesy"
    case Creation        = "Creation"
    case Criticism       = "Criticism"
    case Death           = "Death"
    case Despair         = "Despair"
    case Determination   = "Determination"
    case Disease         = "Disease"
    case Dreams          = "Dreams"
    case Education       = "Education"
    case Enthusiasm      = "Enthusiasm"
    case Envy            = "Envy"
    case Facts           = "Facts"
    case Failure         = "Failure"
    case Faith           = "Faith"
    case Family          = "Family"
    case Fear            = "Fear"
    case Food            = "Food"
    case Forgiveness     = "Forgiveness"
    case Freedom         = "Freedom"
    case Friends         = "Friends"
    case Fun             = "Fun"
    case Generosity      = "Generosity"
    case Genius          = "Genius"
    case Goals           = "Goals"
    case God             = "God"
    case Gossip          = "Gossip"
    case Government      = "Government"
    case Graduation      = "Graduation"
    case Gratitude       = "Gratitude"
    case Greatness       = "Greatness"
    case Grief           = "Grief"
    case Growth          = "Growth"
    case Habits          = "Habits"
    case Happiness       = "Happiness"
    case Hate            = "Hate"
    case Health          = "Health"
    case Heart           = "Heart"
    case Heaven          = "Heaven"
    case History         = "History"
    case Home            = "Home"
    case Honesty         = "Honesty"
    case Honor           = "Honor"
    case Hope            = "Hope"
    case Humor           = "Humor"
    case Hypocrisy       = "Hypocrisy"
    case Ideas           = "Ideas"
    case Idleness        = "Idleness"
    case Ignorance       = "Ignorance"
    case Imagination     = "Imagination"
    case Inspirational   = "Inspirational"
    case Joy             = "Joy"
    case Judgement       = "Judgement"
    case Justice         = "Justice"
    case Kindness        = "Kindness"
    case Knowledge       = "Knowledge"
    case LastWords       = "LastWords"
    case Laughter        = "Laughter"
    case Laziness        = "Laziness"
    case Leadership      = "Leadership"
    case Lies            = "Lies"
    case Life            = "Life"
    case Limitations     = "Limitations"
    case Literature      = "Literature"
    case Loneliness      = "Loneliness"
    case Losing          = "Losing"
    case Love            = "Love"
    case Loyalty         = "Loyalty"
    case Lying           = "Lying"
    case Memory          = "Memory"
    case Mind            = "Mind"
    case Money           = "Money"
    case Mother          = "Mother"
    case Motivational    = "Motivational"
    case Movies          = "Movies"
    case Music           = "Music"
    case Office          = "Office"
    case Opportunity     = "Opportunity"
    case Pain            = "Pain"
    case Patience        = "Patience"
    case Peace           = "Peace"
    case People          = "People"
    case Pets            = "Pets"
    case Perseverance    = "Perseverance"
    case Persistence     = "Persistence"
    case Pleasure        = "Pleasure"
    case Politics        = "Politics"
    case Poverty         = "Poverty"
    case Power           = "Power"
    case Praise          = "Praise"
    case Prayers         = "Prayers"
    case Pride           = "Pride"
    case Problems        = "Problems"
    case Procrastination = "Procrastination"
    case Proverbs        = "Proverbs"
    case Reason          = "Reason"
    case Rebellion       = "Rebellion"
    case Regret          = "Regret"
    case Relationships   = "Relationships"
    case Religion        = "Religion"
    case Repentance      = "Repentance"
    case Respect         = "Respect"
    case Responsibility  = "Responsibility"
    case Revenge         = "Revenge"
    case Romance         = "Romance"
    case Rumor           = "Rumor"
    case Sacrifice       = "Sacrifice"
    case Sad             = "Sad"
    case Sanity          = "Sanity"
    case Science         = "Science"
    case Service         = "Service"
    case Sex             = "Sex"
    case Sin             = "Sin"
    case Sleep           = "Sleep"
    case Songs           = "Songs"
    case Sorrow          = "Sorrow"
    case Sports          = "Sports"
    case Strength        = "Strength"
    case Stress          = "Stress"
    case Stupidity       = "Stupidity"
    case Success         = "Success"
    case Suffering       = "Suffering"
    case Taxes           = "Taxes"
    case Thankfulness    = "Thankfulness"
    case Time            = "Time"
    case Toys            = "Toys"
    case Trouble         = "Trouble"
    case Truth           = "Truth"
    case Understanding   = "Understanding"
    case Valor           = "Valor"
    case Vice            = "Vice"
    case Virtue          = "Virtue"
    case War             = "War"
    case Weakness        = "Weakness"
    case Weddings        = "Weddings"
    case Wisdom          = "Wisdom"
    case Wonder          = "Wonder"
    case Words           = "Words"
    case Work            = "Work"
    case Worrying        = "Worrying"
    case Worship         = "Worship"
    
    case Undefined       = "undef"
    case None            = ""
    
    init() {
       self = .Undefined
    }
    
    func describe() -> String {
        let str = self.rawValue
        return( str )
    }
    

    static let allValues : [Topic] = [
   	.Ability, .Abuse, .Achievement, .Age, .Anger, .Animals, .Anniversary, .Art, .Attitude, .Beauty, .Beginnings,
    .Bible, .Birth, .Books, .Boredom, .Bravery, .BreakingUp, .Brevity, .BrokenHeart, .Caution, .Ceremony,
    .Challenge, .Change, .Character, .Charity, .Children, .Christmas, .College, .Commitment, .CommonSense,
    .Compassion, .Compromise, .Confidence, .Conflict, .Confusion, .Courage, .Courtesy, .Creation, .Criticism,
    .Death, .Despair, .Determination, .Disease, .Dreams, .Education, .Enthusiasm, .Envy, .Facts, .Failure, .Faith,
    .Family, .Fear, .Food, .Forgiveness, .Freedom, .Friends, .Fun, .Generosity, .Genius, .Goals, .God, .Gossip,
    .Government, .Graduation, .Gratitude, .Greatness, .Grief, .Growth, .Habits, .Happiness, .Hate, .Health,
    .Heart, .Heaven, .History, .Home, .Honesty, .Honor, .Hope, .Humor, .Hypocrisy, .Ideas, .Idleness, .Ignorance,
    .Imagination, .Inspirational, .Joy, .Judgement, .Justice, .Kindness, .Knowledge, .LastWords, .Laughter,
    .Laziness, .Leadership, .Lies, .Life, .Limitations, .Literature, .Loneliness, .Losing, .Love, .Loyalty,
    .Lying, .Memory, .Mind, .Money, .Mother, .Motivational, .Movies, .Music, .Office, .Opportunity, .Pain,
    .Patience, .Peace, .People, .Pets, .Perseverance, .Persistence, .Pleasure, .Politics, .Poverty, .Power,
    .Praise, .Prayers, .Pride, .Problems, .Procrastination, .Proverbs, .Reason, .Rebellion, .Regret,
    .Relationships, .Religion, .Repentance, .Respect, .Responsibility, .Revenge, .Romance, .Rumor, .Sacrifice,
    .Sad, .Sanity, .Science, .Service, .Sex, .Sin, .Sleep, .Songs, .Sorrow, .Sports, .Strength, .Stress,
    .Stupidity, .Success, .Suffering, .Taxes, .Thankfulness, .Time, .Toys, .Trouble, .Truth, .Understanding,
    .Valor, .Vice, .Virtue, .War, .Weakness, .Weddings, .Wisdom, .Wonder, .Words, .Work, .Worrying, .Worship,
    .Undefined 
    ]
    
}


func numberOfTopics() -> Int {
    let rv = Topic.allValues.count
    return( rv )
}

class Quote {
    
    var objectID : String? = nil
    var authorID : Int     = 0
    var text     : String  = ""
    var year     : Int     = 0
    var source   : String  = ""
    var fave     : Bool    = false
    var md5      : String  = ""
    var topic    : Topic   = Topic()
    
    
    init() {
        objectID = nil
        authorID = AnonymousID
        text     = ""
        year     = 0
        source   = ""
        fave     = false
        md5      = ""
        topic    = .Undefined
    }
    
    convenience init(txt : String, author : Int, year : Int?, source : String?, fave : Bool, md5 : String?, topic : Topic?) {
        self.init()
        self.text     = txt
        self.authorID = author
        self.fave     = fave
        if let yr = year {
            self.year = yr
        }
        if let src = source {
            self.source = src
        }
        if let tp = topic {
            self.topic = tp
        }
        
        if let sig = md5 {
            self.md5 = sig
        }
        else {
            self.md5 = txt.computeFlatMD5()
        }
    }
    
    convenience init( txt : String ) {
        self.init(txt: txt, author: 0, year: 0, source: nil, fave: false, md5: nil, topic: .Undefined)
    }
    
    convenience init( txt : String, author: Int ) {
        self.init(txt: txt, author: author, year: 0, source: nil, fave: false, md5 : nil, topic: .Undefined)
    }
    convenience init( txt : String, md5: String ) {
        self.init(txt: txt, author: 0, year: 0, source: nil, fave: false, md5: md5, topic: .Undefined)
    }
    convenience init( txt : String, md5: String, source : String ) {
        self.init(txt: txt, author: 0, year: 0, source: source, fave: false, md5: md5, topic: .Undefined)
    }}






