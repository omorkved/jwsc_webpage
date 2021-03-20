module CivMap exposing (..)

--import GoogleMaps.Map as Map
import Browser
import Html exposing (img, Html)
import Html.Attributes exposing (..)

import Element exposing (Element, rgb, image, text, moveDown, moveRight, mouseOver, pointer, centerX, centerY, transparent)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick, onMouseEnter, onMouseLeave)
import Element.Font exposing (color, glow)
import Element.Input
import Element.Border
import Element.Font as Font

type alias Model =
  {count : Int
  , caption : String
  , caption2 : String
  , showAuthors : Bool
  , showFictional : Bool
  , showLocs : Bool
  , showAll : Bool
  }

type Msg
    = GetCaption String String
    | PressButton
    | LocsOnly
    | FictionOnly
    | AuthorOnly
    | ShowAll
    | Noop

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> (Sub.none)
        }


init : () -> ( Model, Cmd Msg )
init () =
  ({count = 0
  , caption = "Hover over a pinned location"
  , caption2 = " "
  , showFictional = False
  , showLocs = False
  , showAuthors = False
  , showAll = True
  }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Noop -> (model, Cmd.none)
    GetCaption str str2 ->
      ({model | caption = str, caption2 = str2}, Cmd.none)

    PressButton ->
      ({model | count = model.count + 1}, Cmd.none)

    LocsOnly -> 
      ({model | showLocs = True, showAuthors = False, showFictional = False, showAll = False}
      , Cmd.none)

    FictionOnly -> 
      ({model | showLocs = False, showAuthors = False, showFictional = True, showAll = False}
      , Cmd.none)

    AuthorOnly -> 
      ({model | showLocs = False, showAuthors = True, showFictional = False, showAll = False}
      , Cmd.none)

    ShowAll -> 
      ({model | showLocs = False, showAuthors = False, showFictional = False, showAll = True}
      , Cmd.none)

    

type alias Person = {name : String, desc : String}
type alias Info =
  {
    place : String
    , events : String
    , people : Person
  }

person : String -> String -> Person
person name desc = {name = name, desc = desc}

noperson : Person
noperson =
  {name = "", desc = ""}

hamberg : Info
hamberg = 
  { place = "Hamberg"
  , events = ""
  , people = (person "Glikl" "Author of Glikl: Memoirs 1691-1719") --, (person "Mendelssohn" "Born in Hamberg")]
  }

amsterdam : Info
amsterdam =
  { place = "Amsterdam"
  , events = "1656, the Amsterdam Jewish community issued to him the writ of cherem against Baruch Spinoza."
  , people = (person "Baruch Spinoza" "Born in Amsterdam. Notable Jewish-Dutch philosopher")
  }


lisbon : Info
lisbon =
  { place = "Lisbon (Portugal)"
  , events = "The Massacre of the New Christians of Lisbon, April, 1506"
  , people = noperson
  }

spain : Info
spain =
  { place = "Spain"
  , events = "Ferdinand and Isabella of Spain expelled Jews from Spain 1492"
  , people = person "Bernarda Manuel" "Writes a defense for herself when she is put on trial during the Spanish Inquisition"
  -- Account of Bernarda Manuel's trial in 1650, Spanish Inquisition
  }


france : Info
france = 
  { place = "France"
  , events = "Declaration of the Rights of Man and Citizen, passed by the French Assembly in 1789, impacting the legal status of Jews in France."
  , people = (person "Zadoc Kahn" "Gives a speech on the acceptance of his position as chief rabbi of France")
  }

italy : Info
italy =
  { place = "Italy"
  , events = ""
  , people = (person "B. Judah Abravanel" "Flees Italy from Portugal. Writes a Poem to His Son (1503)")
  }

france2 : Info
france2 = 
  { place = "France"
  , events = "Setting of 'The Rabbi's Cat'"
  , people = noperson
  }

poland : Info
poland =
  { place = "Poland"
  , events = ""
  , people = (person "Bronislaw Grosser" "Born in Miechow, Poland 1883. Wrote 'From Pole to Jew'")
  }

lithuania : Info
lithuania =
  { place = "Lithuania"
  , events = ""
  , people = (person "Solomon Maimon" "Born in Lithuania. 'The New Hasidism' (1793)")
  }


ukraine1 : Info
ukraine1 =
  { place = "Chernivtsi (Ukraine)"
  , events = "1908 First Yiddish Language Conference"
  , people = (person "Peretz" "Speaks at the First Yiddish Language Conference")
  }

ukraine2 : Info
ukraine2 =
  { place = "Ukraine"
  , events = "Excommunication of the Hasidim written by the rabbinical leaders in Vilna, 1772"
  , people = (person "Reb Nachman" "Born here in 1772. An important Hasidic leader. Author of “The Lost Princess”")
  }


ukraine3 =
  { place = "Ukraine"
  , events = ""
  , people = person "Sholem Aleichem" "Author of 'Tevye the Dairyman'"
  }

kishinev =
  { place = "Kishinev"
  , events = "1903 Pogrom in Kishinev. (As dramatized in 'City of Slaughter')"
  , people = noperson
  }

moscow : Info
moscow =
  { place = "Russia"
  , events = "Moscow: The Tsar banishes Jewish artisans from living or working in Moscow, 1891 (From 'A Good Russian')"
  , people = person "Henrik Sliosberg" "Author of 'A Good Russian'. Chose to stay in Russia over immigrating to the US"
  }

moscow2 : Info
moscow2 =
  { place = "Russia"
  , events = ""
  , people = person "Lara Vapnyar" "Author of 'Things that Are Not Yours'"
  }

newYork : Info
newYork =
  { place = "New York"
  , events = "Setting of Avrom Reyzen's short story, The Abandoned Book"
  , people = person "Yankev Glatshetyn" "Author of 'Sing Ladino' immigrated to New York in 1914"
  }

newYork2 : Info
newYork2 =
  { place = "New York"
  , events = ""
  , people = person "Emma Lazarus" "Birthplace of author of 'The New Colossus'"
  }


brazil =
  {place = "Brazil"
  , events = ""
  , people = person "Clarice Lispector" "A renowned author. She wrote 'Forgiving God'"
  }

israel1 =
  {place = "Israel"
  , events = "Establishment of the modern-day state of Israel, 1948"
  , people = person "Etgar Keret" "Author of 'Shoes' and of many other short stories."
  }

israel2 =
  {place = "Israel"
  , events = "Ben-Gurion served as Israel's first prime minister (Recorded in 'Ben-Gurion and the Bible: The Forging of an Historical Narrative?')"
  , people = person "A. B. Yehoshua" "Author of 'Facing the Forests'"
  }

germany = 
  { place = "Germany"
  , events = "Kristallnacht, a pogram in 1938"
  , people = noperson
  }

pennsylvania =
  { place = "Philadelphia"
  , events = ""
  , people = person "Jacqueline Osherow" "Author of 'Poems from the Alhambra'"
  }


pushpin : Float -> Float -> String -> String -> Bool -> String -> Model -> Element Msg
pushpin right down txt place show caption2 model =
  let
    capt2 = if ((String.length caption2) > 1) && (model.showAll) then (place ++ ": " ++ caption2) else " "
  in
  image 
  [ transparent (not show)
  ,  moveRight right
  , moveDown down
  , pointer
  --, mouseOver --[(glow (rgb 0.8 0.7 0) 100)]
  , onMouseEnter (if show then (GetCaption (place ++ ": " ++ txt) capt2) else Noop)
  , onMouseLeave (GetCaption "Hover over a pinned location" " ")
  --, onClick (GetCaption "more info)
  ]
  {src = "./push_pin3.png", description = "A push pin"}

pushpins : Float -> Float -> Info -> Model -> Element Msg
pushpins right down info model =
  let 
    showAuth = model.showAuthors || model.showAll
    showLocs = model.showLocs || model.showAll
    authTxt = if (String.isEmpty info.people.name) then " " else info.people.name ++ " -- " ++ info.people.desc
  in
  if (not (String.isEmpty info.events)) && showLocs then
    Element.el 
      [ Element.behindContent 
        (pushpin right down authTxt info.place (showAuth && not (String.isEmpty info.people.name)) "" model)]
        (pushpin right (down + 1) info.events info.place (showLocs && not (String.isEmpty info.events)) authTxt model)
  
    else
      pushpin right down authTxt info.place ( showAuth && not (String.isEmpty info.people.name)) "" model



displayButton : Msg -> String -> Bool -> Element Msg
displayButton whichMsg whichText whichBool =
  Element.Input.button 
  [ Element.padding 2
  , if whichBool then Background.color (rgb 0.5 0.5 0.5) else Background.color (rgb 0.95 0.95 1) --(rgb 0.9 0.8 0.8)
  , Border.rounded 5
  , Border.width 2
  , Border.shadow
    { offset = ( 2, 2 )
    , size = 2
    , blur = 2
    , color = (rgb 0.3 0.3 0.3)
    }
   ] 
  {onPress = (Just whichMsg), label = (text whichText)}

view : Model -> Html Msg
view model =
  Element.layout
  [ Element.Border.innerGlow (rgb 0.6 0.807 1) 100
  --, Font.color (Element.rgb 0.4 0.3 0.3)
  , Font.size 14
  , Font.family
    [ Font.typeface "Verdana" --"Open Sans"
    , Font.sansSerif
    ] 
  --, centerX
  ]
  ( Element.column
    []
    [ -- header
      Element.el 
        [ 
          Font.color (Element.rgb 0 0 0)
        , Font.size 20
        , Element.padding 5
        ] 
        (text "JWSC Final")

      -- buttons
      , Element.row [Element.padding 10, Element.spacing 40 ]
         [ Element.el [Font.bold] (text ("Show:"))
         , displayButton LocsOnly "Events" model.showLocs
         , displayButton AuthorOnly "Author Birthplaces" model.showAuthors
         --, displayButton FictionOnly "Settings from Fictional works"
         , displayButton ShowAll "Show All Pins" model.showAll
         ]

      -- caption
      , Element.el [Element.alignLeft] (text model.caption)
      , Element.el [Element.alignLeft] (text model.caption2)

      -- map and pins
        , Element.el
        [ Element.behindContent 
          (Element.image [] {src = "./backgroundMap.png", description = "The world map"})
        ]
        (Element.column [] 
        [ (pushpins 505 106 hamberg model) --doneloc
        , (pushpins 470 77 amsterdam model) --doneloc
        , Element.row []
          [ (pushpins 411 70 lisbon model) --doneloc
          , (pushpins 404 52 france model) --doneloc
          , (pushpins 553 -23 moscow model) --doneloc
          ]
        -- Site of Bernarda Manuel's trial in 1650 -- and of the trials of thousands
        -- more accussed by the inquisition. 
        , Element.row []
            [ (pushpins 82 -5 newYork   model)  
            , (pushpins 392 30 spain   model)  --doneloc
            ]
        , Element.row []
          [(pushpins 110 -50 newYork2   model)
          , (pushpins 525 -95 ukraine1   model)
          ]
        , Element.row []
          [(pushpins 600 -170 ukraine2   model)]
         ])
        , Element.row []
          [(pushpins 603 -190 ukraine3   model)]

        , Element.row []
          [(pushpins 635 -160 israel1   model)]

        , Element.row []
          [(pushpins 560 -375 lithuania   model)]

        , Element.row []
        [(pushpins 569 -345 kishinev   model)]

        , Element.row []
        [(pushpins 509 -430 germany   model)]

        , Element.row []
        [(pushpins 475 -440 france2   model)]

        , Element.row []
        [(pushpins 669 -570 moscow2   model)]

        , Element.row []
        [(pushpins 90 -540 pennsylvania   model)]

        , Element.row []
        [(pushpins 602 -570 israel2   model)]

        , Element.row []
        [(pushpins 520 -650 italy   model)]

        , Element.row []
          [(pushpins 200 -430 brazil   model)]
        
    ])
       
  