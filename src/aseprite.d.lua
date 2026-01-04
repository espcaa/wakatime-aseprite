---@meta

--based on https://github.com/aseprite/api.git 015529ac0b33177a3cb3b331ddc56c841fa22645
---@meta

---The `app` global namespace.
app = {
    ---Active [site](lua://Site) (active image, layer, frame, sprite, etc.).
    ---@type Site
    site = nil,

    ---[Range](lua://Range) member represents the active selection from an objects collection. It returns a sorted list of selected frames, or cels, or layers, or colors, etc.
    ---@type Range
    range = nil,

    ---Gets or sets the active [Cel](lua://Cel) object.
    ---@type Cel | nil
    cel = nil,

    ---Returns a [Frame object](lua://Frame) that represents the active frame in the focused sprite editor. You can set this property assigning a frame number directly to jump to another frame.
    ---@type Frame | nil
    frame = nil,

    ---Returns the active image, an [Image](lua://Image) object.
    ---@type Image | nil
    image = nil,

    ---Returns the active layer, a [Layer](lua://Layer) object.
    ---@type Layer | nil
    layer = nil,

    ---Returns the active sprite, a [Sprite](lua://Sprite) object.
    ---@type Sprite | nil
    sprite = nil,

    ---Returns the active [tag](lua://Tag), which is the tag located at the active frame.
    ---@type Tag | nil
    tag = nil,

    ---Returns the active tool (a [Tool](lua://Tool) object) selected in the tool bar.
    ---@type Tool
    tool = nil,

    ---Returns the active brush (a [Brush](lua://Brush) object) selected in the context bar.
    ---@type Brush
    brush = nil,

    ---Returns the active editor (a [Editor](lua://Editor) object).
    ---@type Editor | nil
    editor = nil,

    ---Returns the main window (a [Window](lua://Window) object).
    ---@type Window | nil
    window = nil,

    ---Returns the Aseprite version number as a [`Version`](lua://Version) object (e.g. `Version("1.2.10-beta1")`).
    ---@type Version
    version = nil,

    ---Returns the API version. See the changes file between version to know what offer each API version.
    apiVersion = 36,

    ---Gets or sets the current foreground [color](lua://Color).
    ---@type Color
    fgColor = nil,

    ---Gets or sets the current background [color](lua://Color). Remember that some commands use the background color to clear the active layer.
    ---@type Color
    bgColor = nil,

    ---Gets or sets the current foreground [tile](lua://Tile).
    ---@type Tile
    fgTile = nil,

    ---Gets or sets the current background [tile](lua://Tile).
    ---@type Tile
    bgTile = nil,

    ---Returns true if the UI is available. E.g. if this is true you can use [app.alert](lua://app.alert) or dialogs. The UI is not available when we run in --batch mode.
    ---@type boolean
    isUIAvailable = nil,

    ---Returns an array of [sprites](lua://Sprite).
    ---@type Sprite[]
    sprites = nil,

    ---This is a table with parameters specified as `--script-param key=value` in the CLI or as `<param>` in `user.aseprite-keys` or `gui.xml` file.
    ---@type table<string, string>
    params = nil,

    ---@type Theme
    theme = nil,

    ---Returns the UI Elements Scaling value specified in *Edit > Preferences* as an scale factor (1 for 100%, 2 for 200%, etc.)
    ---@type number
    uiScale = nil,

    ---Returns the user's default palette, as a [Palette](lua://Palette).
    ---@type Palette
    defaultPalette = nil,

    ---Returns the [`Events`](lua://Events) object to associate functions that can act like listeners of specific `app` events.
    ---@type Events
    events = nil,

    ---Shows an alert message. If `buttons` are not specified, it will show a message box with the `OK` button only.
    ---
    ---Returns an integer with the selected button i.e. 1 if the first button was clicked, 2 if the second one, etc.
    ---@param text string
    ---@return integer buttonClicked
    ---@overload fun(options: { title: string, text: string|string[], buttons: string | string[] }): integer
    alert = function (text) end,

    ---Shows a tooltip message in the status bar. If the duration (in seconds) is not specified, it will default to `2`. The duration can be between `0.5` to `30` seconds.
    ---@param text string
    ---@overload fun(text: string, duration: number)
    ---@overload fun(options: { text: string, duration: number })
    tip = function (text) end,

    ---Opens a new sprite loading it from the given filename. Returns an instance of the [Sprite class](lua://Sprite) or `nil` if something went wrong.
    ---@param filename string
    ---@return Sprite | nil
    open = function (filename) end,

    ---Closes the application. It's like clicking *File > Exit* menu option.
    exit = function () end,

    ---Creates a new transaction so you can group several sprite modifications in just one undo/redo operation. If a string is given as first argument, that string will be used as the label of this undo/redo action (which can be seen in the *Edit > Undo History* window).
    ---
    ---The given function is called inside the transaction, if the function fails, the whole transaction is undone (i.e. all the steps executed so far will be reversed). If the function successes, the transaction is committed and then all actions will be grouped in just one undo/redo operation.
    ---@param func fun()
    ---@overload fun(label: string, func: fun(): any)
    transaction = function (func) end,

    ---This function is available just in case you see that your script updates the sprite but the screen is not showing the updated state of the sprite. It should not be needed, but it's here just in case that something is not working right on the Aseprite side.
    refresh = function () end,

    ---Undoes the latest operation in the active sprite.
    ---It's like calling `app.command.Undo()` (the *Edit > Undo*  menu option).
    undo = function () end,

    ---Redoes the latest undone operation in the active sprite.  It's like calling `app.command.Redo()` (the *Edit > Redo*  menu option).
    redo = function () end,

    ---Simulates an user stroke in the canvas using the given tool.
    ---@param options {
    ---    tool: string | Tool,
    ---    color: Color,
    ---    bgColor: Color,
    ---    brush: Brush,
    ---    points: Point[],
    ---    cel: Cel,
    ---    layer: Layer,
    ---    frame: Frame,
    ---    ink: Ink,
    ---    button: MouseButton,
    ---    opacity: integer,
    ---    contiguous: boolean,
    ---    tolerance: integer,
    ---    freehandAlgorithm: 0 | 1,
    ---    selection: SelectionMode?,
    ---    tilemapMode: TilemapMode?,
    ---    tilesetMode: TilesetMode?,
    ---}
    useTool = function (options) end,

    ---Deprecated. Use [app.sprite](lua://app.sprite).
    ---@deprecated
    ---@type Sprite | nil
    activeSprite = nil,

    ---Deprecated. Use [app.layer](lua://app.layer).
    ---@deprecated
    ---@type Layer | nil
    activeLayer = nil,

    ---Deprecated. Use [app.frame](lua://app.frame).
    ---@deprecated
    ---@type Frame | nil
    activeFrame = nil,

    ---Deprecated. Use [app.cel](lua://app.cel).
    ---@deprecated
    ---@type Cel | nil
    activeCel = nil,

    ---Deprecated. Use [app.image](lua://app.image).
    ---@deprecated
    ---@type Image | nil
    activeImage = nil,

    ---Deprecated. Use [app.tag](lua://app.tag).
    ---@deprecated
    ---@type Tag | nil
    activeTag = nil,

    ---Deprecated. Use [app.tool](lua://app.tool).
    ---@deprecated
    ---@type Tool
    activeTool = nil,

    ---Deprecated. Use [app.brush](lua://app.brush).
    ---@deprecated
    ---@type Brush
    activeBrush = nil,
}

---Set of flags/bits specifying horizontal and vertical alignment of an UI element. You can combine one or several of these values depending on the case/what you are aligning. The specific integer values of each element in this enum might vary in the future.
---@class Align
Align = {
    ---@type Align
    LEFT = nil,

    ---@type Align
    CENTER = nil,

    ---@type Align
    RIGHT = nil,

    ---@type Align
    TOP = nil,

    ---@type Align
    BOTTOM = nil,
}

---@class AniDir
AniDir = {
    ---@type AniDir
    FORWARD = nil,

    ---@type AniDir
    REVERSE = nil,

    ---@type AniDir
    PING_PONG = nil,

    ---@type AniDir
    PING_PONG_REVERSE = nil,
}

---A set of functions to handle the clipboard.
---
---When calling a function with clipboard write access in a script, Aseprite will ask the user if they want to allow the function to run or stop the script.
app.clipboard = {
    ---Gets or sets the clipboard text. Returns `nil` if there is no text.
    ---@type string | nil
    text = nil,

    ---Gets or sets the clipboard [image](lua://Image). Returns `nil` if there is no image. It is recommended to set/get the value once when needed, as the operation may not always be available immediately (in some instances it may take a few milliseconds, see [#5341](https://github.com/aseprite/aseprite/issues/5341#issuecomment-3176395116)).
    ---
    ---Additionally, when calling a method on an image from the clipboard image, the image should be saved to a variable first, instead of calling the method directly on the property (this will not work: `app.clipboard.image:clear()`, see [#5341](https://github.com/aseprite/aseprite/issues/5341#issuecomment-3176395116))
    ---@type Image | nil
    image = nil,

    ---Gets the content of the clipboard, as a table.
    ---@type {
    ---  image: Image | nil,
    ---  selection: Selection | nil,
    ---  palette: Palette | nil,
    ---  tileset: Tileset | nil,
    ---  text: string | nil,
    ---}
    content = nil,

    ---Returns true if the last item copied to the clipboard was text.
    ---@type boolean
    hasText = nil,

    ---Returns true if the last item copied to the clipboard was an [image](lua://Image).
    ---@type boolean
    hasImage = nil,

    ---Clears the clipboard.
    clear = function () end,
}

---Executes the given command named `CommandName` with the specified parameters.
---
---If the command fails to run or is disabled, it will return `false`.
---To check if a command is enabled and can be run, you can use `app.command.[COMMAND NAME].enabled` before calling it.
---@type table<string, any>
app.command = {}

---A set of functions to handle file names and the file system.
app.fs = {
    ---Returns the preferred path separator of the current platform, it is `/` on macOS and Linux, and `\` on Windows. Preferably you should use [app.fs.joinPath()](lua://app.fs.joinPath).
    ---@type "/" | "\\"
    pathSeparator = nil,

    ---Returns the path/directory part (as a string) of the given filename `fn`.
    ---@param fn string
    ---@return string
    filePath = function (fn) end,

    ---Returns the file name (including the extension part) of the given filename `fn`.
    ---@param fn string
    ---@return string
    fileName = function (fn) end,

    ---Returns the file extension (without including the `.`) of the given filename `fn`.
    ---@param fn string
    ---@return string
    fileExtension = function (fn) end,

    ---Returns the file title (without including the path nor the extension) of the given filename `fn`.
    ---@param fn string
    ---@return string
    fileTitle = function (fn) end,

    ---Returns the file path [joined](lua://app.fs.joinPath) with the title (without including the extension) of the given filename `fn`.
    ---@param fn string
    ---@return string
    filePathAndTitle = function (fn) end,

    ---Returns the file path converted to a canonical form for the current platform.
    ---@param path string
    ---@return string
    normalizePath = function (path) end,

    ---Can accept any number of string arguments to join together with the path separator for the current platform.
    ---@param ... string
    ---@return string
    joinPath = function (...) end,

    ---Returns the path the Aseprite executable was launched from.
    ---@type string
    currentPath = nil,

    ---Returns the installation path of Aseprite for the current platform.
    ---@type string
    appPath = nil,

    ---Returns the path for temporary files for the current platform.
    ---
    ---On macOS or Linux it will be `/tmp`, and Windows it will look like `C:\Users\username\AppData\Local\Temp\`.
    ---@type string
    tempPath = nil,

    ---Returns the current user's Documents path for the current platform.
    ---
    ---Depending on the platform, this may return the user's home directory.
    ---@type string
    userDocsPath = nil,

    ---Returns the current user's Aseprite configuration path for the current platform.
    ---
    ---You can learn about the specific location of this folder [from the Aseprite documentation](https://www.aseprite.org/docs/preferences-folder/).
    ---@type string
    userConfigPath = nil,

    ---Returns true if the given filename `fn` is a file.
    ---@param fn string
    ---@return boolean
    isFile = function (fn) end,

    ---Returns true if the given filename `fn` is a directory.
    ---@param fn string
    ---@return boolean
    isDirectory = function (fn) end,

    ---Returns the file size of the given filename `fn`.
    ---@param fn string
    ---@return integer
    fileSize = function (fn) end,

    ---Returns a list of files in the given directory `path`. The returned value is a table where each element is a file name, each file name is relative to the given `path`, they are not full path file names.
    ---@param path string
    ---@return string[]
    listFiles = function (path) end,

    ---Create one directory.
    ---
    ---Returns `true` if the directory was created.
    ---@param path string
    ---@return boolean
    makeDirectory = function (path) end,

    ---Create all directories needed to access to the `path`, so path could be `dir1/dir2/dir3` and the whole hierarchy of directories will be created.
    ---
    ---Returns `true` if all the directories were created.
    ---@param path string
    ---@return boolean
    makeAllDirectories = function (path) end,

    ---Remove the given directory (it must be empty).
    ---
    ---Returns `true` if the directory was removed (or is already removed).
    ---@param path string
    ---@return boolean
    removeDirectory = function (path) end,
}

---A set of functions to get properties about the running Operating System platform.
app.os = {
    ---Returns the platform name. It can be `Windows`, `macOS`, or `Linux`.
    ---@type "Windows" | "macOS" | "Linux"
    name = nil,

    ---Returns an [`Version`](lua://Version) with the Windows or macOS version. It's just `0.0.0` on Linux.
    ---@type Version
    version = nil,

    ---Returns the full platform name with its version. On Linux returns the distribution name with its specific version.
    ---@type string
    fullName = nil,

    ---@type boolean
    windows = nil,

    ---@type boolean
    macos = nil,

    ---@type boolean
    linux = nil,

    ---@type boolean
    x64 = nil,

    ---@type boolean
    x86 = nil,

    ---@type boolean
    arm64 = nil,
}

---This [app](lua://app) property contains a set of function to handle the color for [Image pixels](lua://Image.pixels) at the lowest level: an unsigned integer.
app.pixelColor = {
    ---Constructs a 32-bit unsigned integer for [RGBA](lua://ColorMode.RGB) images. Alpha will be 255 (i.e. 100% opaque) if it's not specified.
    ---@param red integer
    ---@param green integer
    ---@param blue integer
    ---@return integer
    ---@overload fun(red: integer, green: integer, blue: integer, alpha: integer): integer
    rgba = function (red, green, blue) end,

    ---Returns the red component of the given 32-bit integer (`rgbaPixelValue`). This integer is a value created with [app.pixelColor.rgba()](lua://app.pixelColor.rgba) or [Image:getPixel()](lua://Image.getPixel) from a [RGBA](lua://ColorMode.RGB) image.
    ---@param rgbaPixelValue integer
    ---@return integer
    rgbaR = function (rgbaPixelValue) end,

    ---Same as [rgbaR()](lua://app.pixelColor.rgbaR) but with the Green component.
    ---@param rgbaPixelValue integer
    ---@return integer
    rgbaG = function (rgbaPixelValue) end,

    ---Same as [rgbaR()](lua://app.pixelColor.rgbaR) but with the Blue component.
    ---@param rgbaPixelValue integer
    ---@return integer
    rgbaB = function (rgbaPixelValue) end,

    ---Same as [rgbaR()](lua://app.pixelColor.rgbaR) but with the Alpha component.
    ---@param rgbaPixelValue integer
    ---@return integer
    rgbaA = function (rgbaPixelValue) end,

    ---Constructs a 16-bit unsigned integer for [grayscale](lua://ColorMode.GRAYSCALE) images. Alpha will be 255 (i.e. 100% opaque) if it's not specified.
    ---@param gray integer
    ---@return integer
    ---@overload fun(gray: integer, alpha: integer): integer
    graya = function (gray) end,

    ---Returns the gray component of the given 16-bit integer (`grayPixelValue`). This integer is a value created with [app.pixelColor.graya()](lua://app.pixelColor.graya) or [Image:getPixel()](lua://Image.getPixel) from a [grayscale](lua://ColorMode.GRAY) image.
    ---@param grayaPixelValue integer
    ---@return integer
    grayaV = function (grayaPixelValue) end,

    ---Same as [grayaV()](lua://app.pixelColor.grayaV) but with the Alpha component.
    ---@param grayaPixelValue integer
    ---@return integer
    grayaA = function (grayaPixelValue) end,
}

---Gets or sets the given preference `option` in the given `section`.
app.preferences = {
    ---@type table<string, any>
    section = nil,

    ---Returns the preferences of the given [tool](lua://Tool).
    ---@param tool Tool
    ---@return { section: table<string, any> }
    tool = function (tool) end,

    ---Returns the preferences of the given [sprite](lua://Sprite).
    ---@param sprite Sprite
    ---@return { section: table<string, any> }
    document = function (sprite) end,
}

---Blend modes defines how the colors should be mixed when two images overlaps. Used in [Image:drawImage()](lua://Image.drawImage) as input argument.
---@class BlendMode
BlendMode = {
    ---Mix the background colors with the blending image proportionally to its alpha values. Full transparent pixels will show the background.
    ---@type BlendMode
    NORMAL = nil,

    ---A simple copy/paste of the blending image to the background.
    ---@type BlendMode
    SRC = nil,

    ---@type BlendMode
    MULTIPLY = nil,

    ---@type BlendMode
    SCREEN = nil,

    ---@type BlendMode
    OVERLAY = nil,

    ---@type BlendMode
    DARKEN = nil,

    ---@type BlendMode
    LIGHTEN = nil,

    ---@type BlendMode
    COLOR_DODGE = nil,

    ---@type BlendMode
    COLOR_BURN = nil,

    ---@type BlendMode
    HARD_LIGHT = nil,

    ---@type BlendMode
    SOFT_LIGHT = nil,

    ---@type BlendMode
    DIFFERENCE = nil,

    ---@type BlendMode
    EXCLUSION = nil,

    ---@type BlendMode
    HSL_HUE = nil,

    ---@type BlendMode
    HSL_SATURATION = nil,

    ---@type BlendMode
    HSL_COLOR = nil,

    ---@type BlendMode
    HSL_LUMINOSITY = nil,

    ---@type BlendMode
    ADDITION = nil,

    ---@type BlendMode
    SUBTRACT = nil,

    ---@type BlendMode
    DIVIDE = nil,
}

---Identifies a brush to paint with [app.useTool()](lua://app.useTool) function.
---@class Brush
local _brush = {
    ---@type BrushType
    type = nil,

    ---@type integer
    size = nil,

    ---in degrees, from -180 to 180
    ---@type number
    angle = nil,

    ---@type Image
    image = nil,

    ---@type Point
    center = nil,

    ---@type BrushPattern
    pattern = nil,

    ---@type Point
    patternOrigin = nil,
}

---@return Brush
---@overload fun(size: Size): Brush
---@overload fun(image: Image): Brush
---@overload fun(init: {
---  type: BrushType,
---  size: integer,
---  angle: integer,
---  center: Point,
---  image: Image,
---  pattern: BrushPattern,
---  patternOrigin: Point ,
---}): Brush
function Brush () end

---@class BrushPattern
BrushPattern = {
    ---@type BrushPattern
    NONE = nil,

    ---@type BrushPattern
    ORIGIN = nil,

    ---@type BrushPattern
    TARGET = nil,
}

---@class BrushType
BrushType = {
    ---@type BrushType
    CIRCLE = nil,

    ---@type BrushType
    SQUARE = nil,

    ---@type BrushType
    LINE = nil,

    ---@type BrushType
    IMAGE = nil,
}

---A [cel](https://www.aseprite.org/docs/cel/) is an [image](lua://Cel.image) in a specific [*xy*-coordinate](lua://Cel.position), and a specific [layer](lua://Cel.layer)/[frame](lua://Cel.frame) combination.
---@class Cel
local _cel = {
    ---Cels belong to one [sprite](lua://Sprite). This property returns that sprite.
    ---@type Sprite
    sprite = nil,

    ---Returns the [layer](lua://Layer) where this cel is located.
    ---@type Layer
    layer = nil,

    ---Returns the [frame](lua://Frame) object which this cel belongs. If you set this property, the cel will be moved to the given frame (if another cel already exists in that frame, it will be removed).
    ---@type Frame
    frame = nil,

    ---Returns the frame number which this cel belongs, the frame number `1` is the first frame (not `0`). If you set this property the cel will be moved to the given `frameNumber`, check the notes of [Cel.frame](lua://Cel.frame).
    ---@type integer
    frameNumber = nil,

    ---Gets or sets the [image](lua://Image) with the pixels of this cel. This is the preferred way to replace the cel image, because it generates only one undoable action.
    ---@type Image
    image = nil,

    ---Returns the [rectangle](lua://Rectangle) with the cel bounds (position and size).
    ---@type Rectangle
    bounds = nil,

    ---Gets or sets the cel position.
    ---@type Point
    position = nil,

    ---Gets or sets the cel opacity. A value from `0` to `255` (which means `0=0%` completely transparent, or `255=100%` completely opaque).
    ---@type integer
    opacity = nil,

    ---Gets or sets the cel z-index value. By default `0`, which means "show this cel in the same position as its layer", but can be modified to positive values to move the cel to the front, or negative values to move it to the back.
    ---@type integer
    zIndex = nil,

    ---Gets or sets the user-defined [color](lua://Color) of this cel in the timeline.
    ---@type Color
    color = nil,

    ---Gets or sets the user-defined data related to this cel (a text string).
    ---@type string
    data = nil,

    ---Access user-defined and extension-defined [properties](lua://Properties) of this cel.
    ---@type table<string, any>
    ---@overload fun(pluginKey: string): table<string, any>
    properties = nil,
}

---Represents a color that can be choose by the user in different kinds (RGB, HSV, HSL, grayscale, indexed).
---@class Color
local _color = {
    ---@type integer
    alpha = nil,

    ---Get/sets red/green/blue components of the color.
    ---@type integer
    red = nil,

    ---Get/sets red/green/blue components of the color.
    ---@type integer
    green = nil,

    ---Get/sets red/green/blue components of the color.
    ---@type integer
    blue = nil,

    ---@type integer
    hsvHue = nil,

    ---@type integer
    hsvSaturation = nil,

    ---@type integer
    hsvValue = nil,

    ---@type integer
    hslHue = nil,

    ---@type integer
    hslSaturation = nil,

    ---@type integer
    hslLightness = nil,

    ---Gets/sets the [HSV hue](lua://Color.hsvHue) or [HSL hue](lua://Color.hslHue) depending on the kind of color.
    ---@type integer
    hue = nil,

    ---Gets/sets the [HSV saturation](lua://Color.hsvSaturation) or [HSL saturation](lua://Color.hslSaturation) depending on the kind of color.
    ---@type integer
    saturation = nil,

    ---Gets/sets the [HSV value](lua://Color.hsvValue).
    ---@type integer
    value = nil,

    ---Gets/sets the [HSL lightness](lua://Color.hslLightness).
    ---@type integer
    lightness = nil,

    ---Gets or sets the palette index related to this color. If the color is not an index, i.e. it's RGB/HSL/HSV, the closest palette index of the current palette (the palette of the active sprite) that matches the RGB/HSL/HSV values will be returned.
    ---@type integer
    index = nil,

    ---@type integer
    gray = nil,

    ---Returns the [pixel color](lua://app.pixelColor.rgba) which is equivalent to the RGBA values of this color.
    ---@type integer
    rgbaPixel = nil,

    ---Returns the [pixel color](lua://app.pixelColor.graya) which is equivalent to the gray+alpha values of this color.
    ---@type integer
    grayPixel = nil,
}

---@param index integer
---@return Color
---@overload fun(options: { r: number, g: number, b: number, a: integer }): Color
---@overload fun(options: { h: number, s: number, v: number, a: integer }): Color
---@overload fun(options: { h: number, s: number, l: number, a: integer }): Color
---@overload fun(options: { red: integer, green: integer, blue: integer, alpha: integer }): Color
---@overload fun(options: { hue: number, saturation: number, value: number, alpha: integer }): Color
---@overload fun(options: { hue: number, saturation: number, lightness: number, alpha: integer }): Color
---@overload fun(options: { gray: integer, alpha: integer }): Color
---@overload fun(options: { index: integer }): Color
function Color (index) end

---The color mode of an sprite or image specifies the internal structure of each pixel. You can see the [Color Mode section in the Aseprite docs](https://www.aseprite.org/docs/color-mode/) for an introduction about each color mode.
---@class ColorMode
ColorMode = {
    ---You can use this color mode to create RGBA [sprites](lua://Sprite) and [images](lua://Image).
    ---@type ColorMode
    RGB = nil,

    ---You can use this color mode to create gray [sprites](lua://Sprite) and [images](lua://Image). Known as `ColorMode.GRAYSCALE` in previous versions.
    ---@type ColorMode
    GRAY = nil,

    ---You can use this color mode to create indexed [sprites](lua://Sprite) and [images](lua://Image).
    ---@type ColorMode
    INDEXED = nil,

    ---Special color mode used for tilemaps, where each pixel is tile reference in a [tileset](lua://Tileset).
    ---@type ColorMode
    TILEMAP = nil,
}

---Represents the [color space/profile](https://www.aseprite.org/docs/color-profile/) of a [sprite](lua://Sprite), [image](lua://Image), or [image spec](lua://ImageSpec).
---@class ColorSpace
local _colorSpace = {
    ---Get/sets the color space name.
    ---@type string
    name = nil,
}

---Creates an empty color space, sRGB color space, or loads a color profile from the given ICC file specified in `fromFile` parameter.
---@return ColorSpace
---@overload fun(options: { sRGB: boolean }): ColorSpace
---@overload fun(options: { fromFile: string }): ColorSpace
function ColorSpace () end

---The dialog class can be used to show input controls/widgets in the screen to get some data from the user.
---@class Dialog
local _dialog = {
    ---Gets/sets a table with one field for each widget with a given `id`. For each different kind of widget the field is of a different type.
    ---@type { [string]: boolean | string | number | Color | Color[] }
    data = nil,

    ---Gets or sets the position and size (a [rectangle](lua://Rectangle)) of the dialog. This can be useful to align several dialog that must be shown in the same *xy*-position.
    ---@type Rectangle
    bounds = nil,

    ---Gets or sets the dialog autofit, as an [Align](lua://Align) object. The setting will only visually take effect on the dialog after a [Dialog:modify()](lua://Dialog.modify). When set, the dialog window will resize itself, anchoring at the specified value (eg. when autofitting with `Align.LEFT | Align.TOP`, the dialog bounds will shrink to the minimum size anchored at the top left of the dialog).
    ---@type Align
    autofit = nil,

    ---Gets the minimum size (without cutoff) of the dialog window, as a [Size](lua://Size).
    ---@type Size
    sizeHint = nil,

    ---Creates a button.
    ---@param init {
    ---    id: string?,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    text: string?,
    ---    selected: boolean?,
    ---    onclick: fun(ev: MouseEvent)?,
    ---}
    ---@return Dialog
    button = function (self, init) end,

    ---Creates a check box. Arguments are the same as in [Dialog:button](lua://Dialog.button).
    ---@param init {
    ---    id: string?,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    text: string?,
    ---    selected: boolean,
    ---    onclick: fun(ev: MouseEvent)?,
    ---}
    ---@return Dialog
    check = function (self, init) end,

    ---Closes the dialog from a `onclick` [button](lua://Dialog.button) event. By default buttons without an `onclick` event handler will close the dialog, but if you specify a `onclick` function, you have to call this function to close the dialog.
    close = function (self) end,

    ---Creates a button to select a [color](lua://Color).
    ---@param init {
    ---    id: string?,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    color: Color,
    ---    onchange: fun()?,
    ---}
    ---@return Dialog
    color = function (self, init) end,

    ---Creates a combo box/drop-down list.
    ---@param init {
    ---    id: string?,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    option: string,
    ---    options: string[],
    ---    onchange: fun()?,
    ---}
    ---@return Dialog
    combobox = function (self, init) end,

    ---Creates a text entry.
    ---@param init {
    ---    id: string?,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    text: string,
    ---    onchange: fun()?,
    ---}
    ---@return Dialog
    entry = function (self, init) end,

    ---Creates a static label.
    ---@param init {
    ---    id: string?,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    text: string?,
    ---}
    ---@return Dialog
    label = function (dialog, init) end,

    ---Changes properties of the given widget that matches the identifier `id`.
    ---@param options {
    ---    id: string,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    [string]: string | number | boolean | Color | Color[],
    ---}
    modify = function (self, options) end,

    ---Indicates that the next widget should be put in a new row in the dialog (useful to create buttons or several controls of the same type one below the other).
    ---@return Dialog
    ---@overload fun(self: Dialog, options: { always: boolean? })
    newrow = function (self) end,

    ---Creates an entry field to input a number.
    ---@param init {
    ---    id: string,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    text: string,
    ---    decimals: integer?,
    ---    onchange: fun()?,
    ---}
    ---@return Dialog
    number = function (self, init) end,

    ---Creates a radio button. Arguments are the same as in [Dialog:button](lua://Dialog.button).
    ---@param init {
    ---    id: string,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    text: string?,
    ---    selected: boolean?,
    ---    onclick: fun(ev: MouseEvent)?,
    ---}
    ---@return Dialog
    radio = function (self, init) end,

    ---@param init {
    ---    id: string,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    text: string?,
    ---}
    ---@return Dialog
    separator = function (dialog, init) end,

    ---Creates a widget with a set of colors that can be clicked/picked (when `mode="pick"`, which is the default mode) or can be sorted (when `mode="sort"`, which is the default mode).
    ---@param init {
    ---    id: string,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    mode: "pick" | "sort"?,
    ---    colors: Color[],
    ---    onclick: fun(ev: MouseEvent)?,
    ---}
    ---@return Dialog
    shades = function (self, init) end,

    ---Makes the dialog visible to the user. The script code will continue when the dialog is closed by default (pressing a [button](lua://Dialog.button)).
    ---@param options {
    ---    wait: boolean?,
    ---    bounds: Rectangle?,
    ---    autoscrollbars: boolean?,
    ---    hand: boolean?,
    ---}
    ---@return Dialog
    ---@overload fun(self)
    show = function (self, options) end,

    ---Creates a slider in the dialog.
    ---@param init {
    ---    id: string,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    min: integer,
    ---    max: integer,
    ---    value: integer,
    ---    onchange: fun()?,
    ---    onrelease: fun()?,
    ---}
    ---@return Dialog
    slider = function (self, init) end,

    ---If called for the first time (or anytime after a [Dialog:endtabs](lua://Dialog.endtabs) call), it creates a new tabs group and starts the first tab. If called after a previous `Dialog:tab` call, it marks the end of the previous tab and starts a new one.
    ---@param init {
    ---    id: string,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    text: string,
    ---    onclick: fun(ev: MouseEvent)?,
    ---}
    ---@return Dialog
    tab = function (self, init) end,

    ---Marks the end of both the last tab and the group of tabs to which it belongs.
    ---@param options {
    ---    id: string,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    selected: boolean?,
    ---    align: Align,
    ---    onchange: fun()?,
    ---}
    ---@return Dialog
    endtabs = function (self, options) end,

    ---Creates a text entry field + a button to select one file to open or save, possibilities.
    ---@param init {
    ---    id: string,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    title: string?,
    ---    filename: string?,
    ---    basepath: string?,
    ---    open: boolean?,
    ---    save: boolean?,
    ---    entry: boolean?,
    ---    filetypes: string[]?,
    ---    onchange: fun()?,
    ---}
    ---@return Dialog
    file = function (self, init) end,

    ---The Canvas widget provides several events to create an interactive experience with the user.
    ---@param init {
    ---    id: string,
    ---    label: string?,
    ---    focus: boolean?,
    ---    enabled: boolean?,
    ---    visible: boolean?,
    ---    hexpand: boolean?,
    ---    vexpand: boolean?,
    ---    width: integer?,
    ---    height: integer?,
    ---    autoscaling: boolean?,
    ---    onpaint: fun(ev: { context: GraphicsContext }),
    ---    onkeydown: fun(ev: KeyEvent)?,
    ---    onkeyup: fun(ev: KeyEvent)?,
    ---    onmousemove: fun(ev: MouseEvent)?,
    ---    onmousedown: fun(ev: MouseEvent)?,
    ---    onmouseup: fun(ev: MouseEvent)?,
    ---    ondblclick: fun(ev: MouseEvent)?,
    ---    onwheel: fun(ev: MouseEvent)?,
    ---    ontouchmagnify: fun(ev: TouchEvent)?,
    ---}
    ---@return Dialog
    canvas = function (self, init) end,

    ---Will call `onpaint` event of all [canvases](lua://Dialog.canvas) and update the dialog pixels on the screen.
    repaint = function (self) end,
}

---@alias DialogInit {
---    title: string?,
---    autofit: Align?,
---    notitlebar: boolean?,
---    resizeable: boolean?,
---    parent: Dialog?,
---    onclose: fun()?,
---}
---Creates a new dialog. The dialog is hidden, so you have to call [Dialog:show](lua://Dialog.show) function to make it visible. The constructor that receives a `string` will use that string in the title bar of the dialog. The constructor that receives a table can receive a special callback function (`onclose`) that is called when the dialog is closed.
---@return Dialog | nil
---@overload fun(title: string): Dialog | nil
---@overload fun(init: DialogInit): Dialog | nil
function Dialog () end

---References a sprite editor. At the moment we can access only the active editor using [app.editor](lua://app.editor).
---@class Editor
local _editor = {
    ---Returns the [sprite](lua://Sprite) in the editor.
    ---@type Sprite
    sprite = nil,

    ---Returns a [point](lua://Point) of the the mouse position on the sprite, i.e. what pixel is going to be changed if the user clicks the mouse.
    ---@type Point
    spritePos = nil,

    ---Returns a [point](lua://Point) indicating the mouse position on the screen.
    ---@type Point
    mousePos = nil,

    ---Gets or sets the editor zoom as a float. To get a percentage, multiply by 100.
    ---@type number
    zoom = nil,

    ---Gets or sets the editor scroll (coordinates of sprite pixel to center the editor at) as a table, with values `x` and `y` as floats.
    ---@type { x: number, y: number }
    scroll = nil,

    ---Asks the user to select a pixel/point on the sprite. It's similar to what happens when you choose *Edit > New Brush* (but in that case you select a rectangle).
    ---@param options {
    ---    title: string,
    ---    point: Point,
    ---    onclick: fun(ev: MouseEvent),
    ---    onchange: fun(ev: MouseEvent),
    ---    oncancel: fun(ev: MouseEvent),
    ---}
    askPoint = function (self, options) end,

    ---Cancels the [editor:askPoint()](lua://Editor.askPoint) action.
    cancel = function (self) end,
}

---A collection of listeners for specific events. Available for [App.events](lua://app.events) and [Sprite.events](lua://Sprite.events).
---@class Events
local _events = {
    ---Connects the given `function` (2nd argument) with the given event by `eventName` (a `string`, the event name/code/identifier). When the event happens in the future the function will be called automatically. This is like the `function` starts "listening" the event.
    ---@param eventName string
    ---@param callback fun()
    ---@return integer listenerCode
    on = function (self, eventName, callback) end,

    ---Disconnects the given `function` from all events in the object, or stops/breaks only the specific connection identified by `listenerCode` (the code returned by [Events:on()](lua://Events.on)).
    ---@param listenerCode integer
    ---@overload fun(self, callback: fun())
    off = function (self, listenerCode) end,
}

---@class FilterChannels
---@operator bor(FilterChannels): FilterChannels
FilterChannels = {
    ---@type FilterChannels
    RED = nil,

    ---@type FilterChannels
    GREEN = nil,

    ---@type FilterChannels
    BLUE = nil,

    ---@type FilterChannels
    ALPHA = nil,

    ---@type FilterChannels
    GRAY = nil,

    ---@type FilterChannels
    INDEX = nil,

    ---Same as `FilterChannels.RED | FilterChannels.GREEN | FilterChannels.BLUE`.
    ---@type FilterChannels
    RGB = nil,

    ---Same as `FilterChannels.RED | FilterChannels.GREEN | FilterChannels.BLUE | FilterChannels.ALPHA`.
    ---@type FilterChannels
    RGBA = nil,

    ---Same as `FilterChannels.GRAY | FilterChannels.ALPHA`.
    ---@type FilterChannels
    GRAYA = nil,
}

---Type of flipping to be used in [image:flip](lua://Image.flip)
---@class FlipType
FlipType = {
    ---Defines a type of image flip that horizontally flips an image across the vertical axis.
    ---@type FlipType
    HORIZONTAL = nil,

    ---Defines a type of image flip that vertically flips an image across the horizontal axis.
    ---@type FlipType
    VERTICAL = nil,

    ---Defines a type of image flip that both vertically and horizontally flips an image across the diagonal axis.
    ---@type FlipType
    DIAGONAL = nil,
}

---This is an auxiliary object that points to a given frame in the sprite and can be used to adjust information about that frame. If you modify the number of frames in the sprite, or the structure of the frames, a `Frame` object will still pointing to the same frame number.
---@class Frame
local _frame = {
    ---Returns the [sprite](lua://Sprite) of this frame.
    ---@type Sprite
    sprite = nil,

    ---Returns the frame number. `1` is the first frame in the animation and this `frame` is equal to `frame == frame.sprite.frames[frameNumber]`.
    ---@type integer
    frameNumber = nil,

    ---Gets or sets the duration of this frame in the animation in seconds. E.g. `0.3333` means that this frame will be `1/3` of a second in the screen when the animation is being played.
    ---@type number
    duration = nil,

    ---Returns `Frame` object in the previous frame number or `nil` if this is the first frame.
    ---@type Frame | nil
    previous = nil,

    ---Returns `Frame` object in the next frame number or `nil` if this is the last frame.
    ---@type Frame | nil
    next = nil,
}
---@class GraphicsContext
local _graphicsContext = {
    ---Gets the width of the visible area in pixels. Canvas dimensions change when the dialog is resized by the user.
    ---@type integer
    width = nil,

    ---Gets the height of the visible area in pixels. Canvas dimensions change when the dialog is resized by the user.
    ---@type integer
    height = nil,

    ---Gets or sets whether paths and shapes are painted on using antialiasing.
    ---@type boolean
    antialias = nil,

    ---Gets or sets the [color](lua://Color) to paint with the path functions.
    ---@type Color
    color = nil,

    ---Gets or sets the width of lines painted when calling [GraphicsContext:stroke()](lua://GraphicsContext.stroke) or [GraphicsContext:strokeRect()](lua://GraphicsContext.strokeRect).
    ---@type number
    strokeWidth = nil,

    ---[Blend mode](lua://BlendMode) used in [stroke()](lua://GraphicsContext.stroke), [fill()](lua://GraphicsContext.fill), [drawImage()](lua://GraphicsContext.drawImage), etc.
    ---@type BlendMode
    blendMode = nil,

    ---Opacity used in [stroke()](lua://GraphicsContext.stroke), [fill()](lua://GraphicsContext.fill), [drawImage()](lua://GraphicsContext.drawImage), etc.
    ---@type integer
    opacity = nil,

    ---It has the same functionality as [app.theme](lua://app.theme), with the only difference that the values returned by accessing dimensions or style metrics data are not affected by the current UI Scale setting. This is useful when you are drawing on a dialog canvas's GraphicsContext with [autoScaling](lua://Dialog.canvas) enabled, so you don't have to worry about adjusting sizes and measures when painting on the canvas using the current theme.
    ---@type Theme
    theme = nil,

    ---Saves the current state of the canvas to [restore](lua://GraphicsContext.restore) it later, including: [color](lua://GraphicsContext.color), [opacity](lua://GraphicsContext.opacity), [blendMode](lua://GraphicsContext.blendMode), [stroke width](lua://GraphicsContext.strokeWidth), [clipping region](lua://GraphicsContext.clip).
    save = function (self) end,

    ---Restores the last [saved](lua://GraphicsContext.save) canvas state.
    restore = function (self) end,

    ---Sets the [current path](lua://GraphicsContext.beginPath) as a clipping area for following drawing operations.
    clip = function (self) end,

    ---Paints the edges of the given [rectangle](lua://Rectangle) with the [current color](lua://GraphicsContext.color) and [current width](lua://GraphicsContext.strokeWidth).
    ---@param rectangle Rectangle
    strokeRect = function (self, rectangle) end,

    ---Fills the given [rectangle](lua://Rectangle) with the [current color](lua://GraphicsContext.color).
    ---@param rectangle Rectangle
    fillRect = function (self, rectangle) end,

    ---Draws on the canvas the given text string, at a position specified by the *xy*-coordinates.
    ---@param text string
    ---@param x number
    ---@param y number
    fillText = function (self, text, x, y) end,

    ---Returns the [size](lua://Size) of the given text using the current font.
    ---@param text string
    ---@return Size
    measureText = function (self, text) end,

    ---Draws on the canvas the given image.
    ---@param image Image
    ---@param x number
    ---@param y number
    ---@overload fun(self, image: Image, srcRect: Rectangle, dstRect: Rectangle)
    ---@overload fun(
    ---    self,
    ---    image: Image,
    ---    srcX: number,
    ---    srcY: number,
    ---    srcW: number,
    ---    srcH: number,
    ---    dstX: number,
    ---    dstY: number,
    ---    dstW: number,
    ---    dstH: number,
    ---)
    drawImage = function (self, image, x, y) end,

    ---Draws on the canvas a theme part specified by the given *partId*, at a given [Point](lua://Point) or at specified *xy*-coordinates.
    ---@param partId string
    ---@param point Point
    ---@overload fun(self, partId: string, x: number, y: number)
    drawThemeImage = function (self, partId, point) end,

    ---Draws on the canvas a theme part specified by the given *partId*, filling a given [Rectangle](lua://Rectangle) or at specified *xy*-coordinates, with given width and height. This method uses [nine-slice scaling](https://en.wikipedia.org/wiki/9-slice_scaling) for parts that have their [Slice's center](lua://Slice.center) defined.
    ---@param partId string
    ---@param rectangle Rectangle
    ---@overload fun(self, partId: string, x: number, w: number, w: number, h: number)
    drawThemeRect = function (self, partId, rectangle) end,

    ---Starts a new path, emptying the list of tracked sub-paths. This is the first method to call when drawing paths.
    beginPath = function (self) end,

    ---Closes the current sub-path by connecting the current point with the first point of the current sub-path.
    closePath = function (self) end,

    ---Starts a new sub-path at the specified *xy*-coordinates. This is the second method to call (after [GraphicsContext:beginPath()](lua://GraphicsContext.beginPath)) when drawing paths.
    ---@param x number
    ---@param y number
    moveTo = function (self, x, y) end,

    ---Adds a line to the current sub-path, from the last point to the specified *xy*-coordinates.
    ---@param x number
    ---@param y number
    lineTo = function (self, x, y) end,

    ---Adds a cubic [Bézier curve](https://en.wikipedia.org/wiki/B%C3%A9zier_curve) to the current sub-path, from the last point to the specified *xy*-coordinates, with two control points (specified by *cp1x/cp1y* and *cp2x/cp2y* coordinates).
    ---@param cp1x number
    ---@param cp1y number
    ---@param cp2x number
    ---@param cp2y number
    ---@param x number
    ---@param y number
    cubicTo = function (self, cp1x, cp1y, cp2x, cp2y, x, y) end,

    ---Adds an oval enclosed by the given [Rectangle](lua://Rectangle) to the current sub-path.
    ---@param rectangle Rectangle
    oval = function (self, rectangle) end,

    ---Adds a given [Rectangle](lua://Rectangle) to the current sub-path.
    ---@param rectangle Rectangle
    rect = function (self, rectangle) end,

    ---Adds a given [Rectangle](lua://Rectangle) to the current sub-path with rounded corners.
    ---@param rectangle Rectangle
    ---@param r number
    ---@overload fun(self, rectangle: Rectangle, rx: number, ry: number)
    roundedRect = function (self, rectangle, r) end,

    ---Paints the edges of the [current path](lua://GraphicsContext.beginPath) with the [current color](lua://GraphicsContext.color) and [current width](lua://GraphicsContext.strokeWidth).
    stroke = function (self) end,

    ---Fills the [current path](lua://GraphicsContext.beginPath) with the [current color](lua://GraphicsContext.color).
    fill = function (self) end,
}

---This is an object that defines the grid for a [tileset](lua://Tileset).
---@class Grid
local _grid = {
    ---Returns the [tile](lua://Tile) width and height of a [tileset](lua://Tileset), as a [size](lua://Size).
    ---@type Size
    tileSize = nil,

    ---Returns the origin of the grid as a [point](lua://Point).
    ---@type Point
    origin = nil,
}

---@return Grid
---@overload fun(otherGrid: Grid): Grid
function Grid () end

---An image object. Each [cel](https://www.aseprite.org/docs/cel/) has one image (all [linked cels](https://www.aseprite.org/docs/linked-cels/) share the same image).
---@class Image
local _image = {
    ---Creates a copy of the given image. You can use the `Image(otherImage)` constructor for the same behavior.
    ---@return Image
    clone = function (self) end,

    ---Internal unique ID (an integer) assigned to this image inside the program. You can use it to identify this image in your script.
    ---@type integer
    id = nil,

    ---Internal version (an integer) assigned to this image inside the program. It's always incremented when the image is modified. Can be used to cache some complex calculation related to the image and recalculate it only if the version is modified (which means the pixels are modified).
    ---@type integer
    version = nil,

    ---Returns the width of the image in pixels.
    ---@type integer
    width = nil,

    ---Returns the height of the image in pixels.
    ---@type integer
    height = nil,

    ---Returns a [rectangle](lua://Rectangle) with the bounds of the image with origin equal to (0, 0).
    ---@type Rectangle
    bounds = nil,

    ---Image [color mode](lua://ColorMode).
    ---@type ColorMode
    colorMode = nil,

    ---The [specification](lua://ImageSpec) for this image.
    ---@type ImageSpec
    spec = nil,

    ---Returns the [cel](lua://Cel) to which this image belongs or `nil` if this image is not associated to a cel.
    ---@type Cel | nil
    cel = nil,

    ---A byte string that contains raw image data. The layout depends on the image's color mode. It can be used with the usual string methods, or split into bytes using `string.bytes`. For editing the image, it's easier to use `image:pixels()`.
    ---@type string
    bytes = nil,

    ---Number of bytes for each row in the image. Each image has a total of `image.rowStride * image.height` bytes. It's useful if you are going to get or set the [Image.bytes](lua://Image.bytes) property manually.
    ---@type integer
    rowStride = nil,

    ---Number of bytes per pixel.
    ---@type integer
    bytesPerPixel = nil,

    ---Clears the image pixels in a given [bounds](lua://Rectangle) with a the given [color](lua://Color). The entire image is erased by default if no bounds present. `image.spec.transparentColor` if no color specified.
    ---@override fun(self, color: Color)
    ---@override fun(self, bounds: Rectangle, color: Color)
    clear = function (self) end,

    ---Sets the pixel in the *xy*-coordinate to the given [integer pixel value](lua://app.pixelColor). The *xy*-coordinate is relative to the image, so pixel (0, 0) is the first pixel at the top-left coorner in the image, not in the sprite canvas.
    ---@param x integer
    ---@param y integer
    ---@param color integer
    drawPixel = function (self, x, y, color) end,

    ---Gets the pixel in the *xy*-coordinate.
    ---@param x integer
    ---@param y integer
    ---@return integer
    getPixel = function (self, x, y) end,

    ---@param sourceImage Image
    ---@overload fun(self, sourceImage: Image, position: Point)
    ---@overload fun(self, sourceImage: Image, position: Point, opacity: integer)
    ---@overload fun(self, sourceImage: Image, position: Point, opacity: integer, blendMode: BlendMode)
    drawImage = function (self, sourceImage) end,

    ---@param sourceSprite Sprite
    ---@param frameNumber integer
    ---@overload fun(self, sourceSprite: Sprite, frameNumber: integer, position: Point)
    drawSprite = function (self, sourceSprite, frameNumber) end,

    ---@param anotherImage Image
    ---@return boolean
    isEqual = function (self, anotherImage) end,

    ---@return boolean
    isEmpty = function (self) end,

    ---@param color Color | integer
    ---@return boolean
    isPlain = function (self, color) end,

    ---@class _Pixel
    ---@field x integer
    ---@field y integer
    ---@operator call(integer?): integer

    ---@param rectangle? Rectangle
    ---@return fun(): _Pixel
    pixels = function (self, rectangle) end,

    ---@deprecated
    ---@param x integer
    ---@param y integer
    ---@param color integer
    putPixel = function (self, x, y, color) end,

    ---@deprecated
    ---@param image Image
    ---@param position? Point
    putImage = function (self, image, position) end,

    ---@deprecated
    ---@param sprite Sprite
    ---@param frameNumber integer
    ---@param position Point
    putSprite = function (self, sprite, frameNumber, position) end,

    ---@param filename string
    ---@overload fun(self, options: { filename: string, palette: Palette? })
    saveAs = function (self, filename) end,

    ---@param width integer
    ---@param height integer
    ---@overload fun(self, options: { width: integer, height: integer, method: ("bilinear" | "rotsprite")?, pivot: Point? })
    ---@overload fun(self, options: { size: Size, method: ("bilinear" | "rotsprite")?, pivot: Point? })
    resize = function (self, width, height) end,

    ---@overload fun(self, refColor: Color)
    shrinkBounds = function (self) end,

    ---@overload fun (self, type: FlipType)
    flip = function (self) end,
}

---Creates a new image with the given `width` and `height`. The [color mode](lua://ColorMode) is optional, [RGB](lua://ColorMode.RGB) by default.
---@param width integer
---@param height integer
---@param colorMode? ColorMode
---@return Image
---@overload fun(spec: ImageSpec): Image
---@overload fun(sprite: Sprite): Image
---@overload fun(otherImage: Image, rectangle?: Rectangle): Image
---@overload fun(option: { fromFile: string }): Image
function Image (width, height, colorMode) end

---It's a simple object that contains some specifications to create new [sprites](lua://Sprite) or [images](lua://Image), or to get the information (specs) of a [sprite](lua://Sprite.spec) or [image](lua://Image.spec), like the canvas size (width/height), [color mode](lua://ColorMode), and color space. Often abbreviated as 'spec' in the API.
---@class ImageSpec
local _imageSpec = {
    ---Gets or sets the [color mode](lua://ColorMode) of the image or sprite.
    ---@type ColorMode
    colorMode = nil,

    ---Gets or sets the width of the image or sprite.
    ---@type integer
    width = nil,

    ---Gets or sets the height of the image or sprite.
    ---@type integer
    height = nil,

    ---Gets or sets the [color space](lua://ColorSpace) for an image or sprite.
    ---@type ColorSpace
    colorSpace = nil,

    ---Gets or sets the index that refers a transparent color in a palette when the image or sprite uses indexed [color mode](lua://ColorMode).
    ---@type Color
    transparentColor = nil,
}

---Creates a new `ImageSpec` instance.
---@return ImageSpec
---@overload fun(otherImageSpec: ImageSpec): ImageSpec
---@overload fun(options: { width: integer, height: integer, colorMode: ColorMode, transparentColor: number })
function ImageSpec () end

---More info about each ink type behavior at [https://www.aseprite.org/docs/ink/](https://www.aseprite.org/docs/ink/).
---@class Ink
Ink = {
    ---Value `0` or `"simple"` string.
    ---@type Ink
    SIMPLE = nil,

    ---Value `1`, `"alpha_compositing"`, or `"alpha-compositing"`.
    ---@type Ink
    ALPHA_COMPOSTING = nil,

    ---Value `2`, `"copy_color"`, or `"copy-color"`.
    ---@type Ink
    COPY_COLOR = nil,

    ---Value `3`, `"lock_alpha"`, or `"lock-alpha"`.
    ---@type Ink
    LOCK_ALPHA = nil,

    ---Value `4`, or `"shading"`.
    ---@type Ink
    SHADING = nil,
}

---Since **Aseprite v1.3-rc5** you have this `json` global namespace. It provides a couple of functions to decode JSON objects from strings to Lua objects/tables and viceversa.
json = {
    ---Parses the given `jsonText` and returns a Lua table-like object `jsonObj` that represents the given data.
    ---@param jsonText string
    ---@return any
    decode = function (jsonText) end,

    ---Converts the given Lua-table into a JSON text.
    ---@param luaTable any
    ---@return string
    encode = function (luaTable) end,
}

---This object is received as first parameter in the function associated to `onkeydown` or `onkeyup` events of a [canvas](lua://Dialog.canvas) widget.
---@class KeyEvent
local _keyEvent = {
    ---Number of times the key was autorepeated. This can happen when the user presses and holds a key.
    ---@type integer
    repeatCount = nil,

    ---A string containing the pressed/released Unicode character.
    ---@type string
    key = nil,

    ---A string that identifies the pressed/released key, similar to the values found in https://developer.mozilla.org/en-US/docs/Web/API/UI_Events/Keyboard_event_code_values, one of the following values.
    ---@type string
    code = nil,

    ---True if the <kbd>Alt</kbd> key was pressed when the event occurs.
    ---@type boolean
    altKey = nil,

    ---True if the <kbd>Windows</kbd> key (or <kbd>Command</kbd> key on macOS) was pressed when the event occurs.
    ---@type boolean
    metaKey = nil,

    ---True if the <kbd>Ctrl</kbd> key was pressed when the event occurs.
    ---@type boolean
    ctrlKey = nil,

    ---True if the <kbd>Shift</kbd> key was pressed when the event occurs.
    ---@type boolean
    shiftKey = nil,

    ---True if the <kbd>Space</kbd> key was pressed when the event occurs.
    ---@type boolean
    spaceKey = nil,

    ---Stops propagating this event to other parent widget/main Aseprite window. Use this in case that your canvas widget used the key and you want to avoid triggering a command with a keyboard shortcut.
    stopPropagation = function (self) end,
}

---Layers are arranged as a stack within a sprite. Layers may nest within each other to form a hierarchy. Layers that accept children are group layers.
---@class Layer
local _layer = {
    ---Gets the [sprite](lua://Sprite) to which this layer belongs.
    ---@type Sprite
    sprite = nil,

    ---Gets or sets the layer name, a `string`.
    ---@type string
    name = nil,

    ---Gets or sets the layer opacity, a value from `0` to `255`. The layer is completely transparent when the value is `0`; opaque when the value is `255`. When the layer is a [background](lua://Layer.isBackground), returns `255`.
    ---@type integer?
    opacity = nil,

    ---Gets or sets the layer blending mode (how colors are blend with the layer below). It's expressed as an integer or a value from the [BlendMode](lua://BlendMode) enumeration.
    ---@type BlendMode?
    blendMode = nil,

    ---If a layer is a [group](lua://Layer.isGroup), gets the `table` of child layers for which the group serves as a [parent](lua://Layer.parent). If the layer is not a group, returns `nil`.
    ---@type Layer[] | nil
    layers = nil,

    ---Gets or sets the layer's parent. The parent may be either a [sprite](lua://Sprite) or a [group](lua://Layer.isGroup) layer.
    ---@type Sprite | Layer
    parent = nil,

    ---Gets or sets the layer's index in its parent's layers `table`. In other words, this is the layer's place in the local stack. Layers stack in descending order. For example, a layer with index `1` will lie beneath a layer with index `2`, assuming the layers share the same parent.
    ---@type integer
    stackIndex = nil,

    ---Returns the [uuid](lua://Uuid) of the layer.
    ---@type Uuid
    uuid = nil,

    ---Gets whether or not the layer contains [cels](lua://Cel) with [images](lua://Image).
    ---@type boolean
    isImage = nil,

    ---Gets whether or not the layer is a group and *has the capacity* to be a parent to other layers. A layer may be a group, yet have no children; in such a case, its [layers](lua://Layer.layers) property will return a table of zero length.
    ---@type boolean
    isGroup = nil,

    ---Returns true if the layer is a tilemap (contains a [tileset](lua://Layer.tileset))
    ---@type boolean
    isTilemap = nil,

    ---Gets whether or not a layer supports transparency. The opposite of the property [Layer.isBackground](lua://Layer.isBackground). For [indexed color mode](lua://ColorMode.INDEXED), the layer may contain images with a [transparent color](lua://ImageSpec.transparentColor) index. For RGB or grayscale color mode, the layer may contain images with an alpha channel.
    ---@type boolean
    isTransparent = nil,

    ---Gets whether or not a layer is a background. The opposite of the property [Layer.isTransparent](lua://Layer.isTransparent). Background layers do not contain images which support transparency. Returns `false` if the layer is a [group](lua://Layer.isGroup).
    ---@type boolean
    isBackground = nil,

    ---Gets or sets whether a layer is editable, unlocked in other words.
    isEditable = nil,

    ---Gets or sets whether or not the layer is visible.
    ---@type boolean
    isVisible = nil,

    ---Gets or sets whether a layer biases toward linked [cels](lua://Cel) when a new cel is created in the timeline.
    ---@type boolean
    isContinuous = nil,

    ---Gets or sets whether or not a [group](lua://Layer.isGroup) layer is collapsed, i.e., whether its child layers are hidden in the timeline. The opposite of the property [Layer.isExpanded](lua://Layer.isExpanded).
    ---@type boolean
    isCollapsed = nil,

    ---Gets or sets whether or not a [group](lua://Layer.isGroup) layer is expanded, meaning whether its child layers are visible in the timeline. The opposite of the property [Layer.isCollapsed](lua://Layer.isCollapsed).
    ---@type boolean
    isExpanded = nil,

    ---Gets whether or not the layer is a reference layer. You cannot change the value of this property.
    ---@type boolean
    isReference = nil,

    ---Gets a `table` of [cels](lua://Cel) in the layer. If the layer is a [group](lua://Layer.isGroup), this property will return a table of zero length.
    ---@type Cel[]
    cels = nil,

    ---Gets or sets the user-defined [color](lua://Color) of this layer in the timeline.
    ---@type Color
    color = nil,

    ---Gets or sets the user-defined data related to this layer (a text string).
    ---@type string
    data = nil,

    ---Access user-defined and extension-defined [properties](lua://Properties) of this layer.
    ---@type table<string, any>
    ---@overload fun(pluginKey: string): table<string, any>
    properties = nil,

    ---Returns a [cel](lua://Cel), if any, at the intersection of the layer and a frame. The frame may be either a [frame](lua://Frame) object or its [frame number](lua://Frame.frameNumber), an integer. If there is no cel at that intersection, returns `nil`.
    ---@param frame integer | Frame
    ---@return Cel | nil
    cel = function (self, frame) end,

    ---@type Tileset | nil
    tileset = nil,
}

---@class MouseButton
MouseButton = {
    ---@type MouseButton
    NONE = nil,

    ---@type MouseButton
    LEFT = nil,

    ---@type MouseButton
    RIGHT = nil,

    ---@type MouseButton
    MIDDLE = nil,

    ---@type MouseButton
    X1 = nil,

    ---@type MouseButton
    X2 = nil,
}

---Mouse cursor that can be set in a [canvas widget](lua://Dialog.canvas) using: `dialog:modify{ id=canvasId, mousecursor=newMouseCursor }`
---@class MouseCursor
MouseCursor = {
    ---@type MouseCursor
    NONE = nil,

    ---@type MouseCursor
    ARROW = nil,

    ---@type MouseCursor
    CROSSHAIR = nil,

    ---@type MouseCursor
    POINTER = nil,

    ---@type MouseCursor
    NOT_ALLOWED = nil,

    ---@type MouseCursor
    GRAB = nil,

    ---@type MouseCursor
    GRABBING = nil,

    ---@type MouseCursor
    MOVE = nil,

    ---@type MouseCursor
    NS_RESIZE = nil,

    ---@type MouseCursor
    WE_RESIZE = nil,

    ---@type MouseCursor
    N_RESIZE = nil,

    ---@type MouseCursor
    NE_RESIZE = nil,

    ---@type MouseCursor
    E_RESIZE = nil,

    ---@type MouseCursor
    SE_RESIZE = nil,

    ---@type MouseCursor
    S_RESIZE = nil,

    ---@type MouseCursor
    SW_RESIZE = nil,

    ---@type MouseCursor
    W_RESIZE = nil,

    ---@type MouseCursor
    NW_RESIZE = nil,
}

---This object is received as first parameter in the function associated to `onmousedown`, `onmouseup`, `onmousemove`, or `onwheel` events of a [canvas](lua://Dialog#dialogcanvas) widget.
---@class MouseEvent
local _mouseEvent = {
    ---The (x,y) position of the mouse when the event happens, in client coordinates, where (0,0) is the top-left corner of the canvas widget.
    ---@type integer
    x = nil,

    ---See [MouseEvent.x](lua://MouseEvent#mouseeventx)
    ---@type integer
    y = nil,

    ---The [MouseButton](lua://MouseButton#mousebutton) pressed or released by the user.
    ---@type MouseButton
    button = nil,

    ---The pressure of pen when the event is generated from a stylus.
    ---@type number
    pressure = nil,

    ---Only for the `onwheel` event.
    ---@type integer
    deltaX = nil,

    ---Only for the `onwheel` event.
    ---@type integer
    deltaY = nil,

    ---True if the Alt key was pressed when the event occurs.
    ---@type boolean
    altKey = nil,

    ---True if the Windows key (or Command key on macOS) was pressed when the event occurs.
    ---@type boolean
    metaKey = nil,

    ---True if the Ctrl key was pressed when the event occurs.
    ---@type boolean
    ctrlKey = nil,

    ---True if the Shift key was pressed when the event occurs.
    ---@type boolean
    shiftKey = nil,

    ---True if the Space key was pressed when the event occurs.
    ---@type boolean
    spaceKey = nil,
}

---@class Palette
---@operator len: integer
local _palette = {
    ---Changes the number of the palette colors to `ncolors` (an integer value).
    ---@param ncolors integer
    resize = function (self, ncolors) end,

    ---Returns the [color](lua://Color#color) in the given entry `index` (the `index` goes from `0` to `#palette-1`).
    ---@param index integer
    ---@return Color
    getColor = function (self, index) end,

    ---Changes a palette color in the given entry `index` (the `index` goes from `0` to `#palette-1`). The `color` can be a [Color](lua://Color#color) object or an [integer pixel value](lua://app#apppixelcolor).
    ---@param index integer
    ---@param color Color | integer
    setColor = function (self, index, color) end,

    ---At the moment it will always return the first [frame](lua://Frame#frame), but in the near future Aseprite will support palette changes over time (in different frames), so this field should be the frame number where the palette is displayed for the first time in the [sprite](lua://Sprite#sprite).
    ---@type Frame
    frame = nil,

    ---Saves the palette in the given `filename`.
    ---@param filename string
    saveAs = function (self, filename) end,
}

---Creates a new palette. By default it will contain 256 colors, but you can specify a `numberOfColors` (integer value). `otherPalette` can be another palette object to create a copy of it. If `fromFile` is given, the palette is loaded from the file name. If `fromResource` is given, the `resourceID` is an ID specified in one of the [extensions palette](https://github.com/aseprite/aseprite/tree/main/data/extensions) (e.g. [DB16](https://github.com/aseprite/aseprite/blob/8e193b592ae06abb36be6f72ef43c308b511b24c/data/extensions/dawnbringer-palettes/package.json#L13), [DB32](https://github.com/aseprite/aseprite/blob/8e193b592ae06abb36be6f72ef43c308b511b24c/data/extensions/dawnbringer-palettes/package.json#L14), [Solarized](https://github.com/aseprite/aseprite/blob/8e193b592ae06abb36be6f72ef43c308b511b24c/data/extensions/software-palettes/package.json#L15)).
---@return Palette
---@overload fun(ncolors: integer): Palette
---@overload fun(otherPalette: Palette): Palette
---@overload fun(options: { fromFile: string })
---@overload fun(options: { fromResource: string })
function Palette () end

---@class Plugin
local _plugin = {
    ---Name of the extension.
    ---@type string
    name = nil,

    ---Display name of the extension.
    ---@type string
    displayName = nil,

    ---Version of the extension.
    ---@type Version
    version = nil,

    ---Path where the extension is installed.
    ---@type string
    path = nil,

    ---It's a Lua table where you can load/save any kind of Lua value here and they will be saved/restored automatically on each session.
    ---@type table<string, any>
    preferences = nil,

    ---Creates a new command that can be associated to keyboard shortcuts and it's added in the app menu in the specific `"group"`. Groups are defined in the [gui.xml file](https://github.com/aseprite/aseprite/blob/main/data/gui.xml) inside the `<menus>` element. `onclick`: Function to be called when the command is executed (clicked or an associated keyboard shortcut pressed). `onenabled`: Optional function to know if the command should be available (enabled or disabled). It should return true if the command can be executed right now. If this function is not specified, the command will always be available to be executed by the user. `onchecked`: Optional function to know if the command should be checked or not. The function is called every time the command is displayed in a menu (e.g: a dropdown is opened). It should return true if it is checked. If this function is not specified, the command will be unchecked.
    ---@param init {
    ---    id: string,
    ---    title: string,
    ---    group: string,
    ---    onclick: fun(),
    ---    onenabled: (fun(): boolean),
    ---    onchecked: (fun(): boolean),
    ---}
    newCommand = function (self, init) end,

    ---Creates a new menu item which will contain a submenu grouping several plugin commands. `id`: ID to identify this new menu group in [Plugin:newCommand{ ..., group=id, ... }](lua://Plugin#pluginnewcommand) calls to add several command/menu items as elements of this group submenu. `group`: In which existent group we should add this new menu item. Existent app groups are defined in the [gui.xml file](https://github.com/aseprite/aseprite/blob/main/data/gui.xml) inside the `<menus>` element.
    ---@param init {
    ---    id: string,
    ---    title: string,
    ---    group: string,
    ---}
    newMenuGroup = function (self, init) end,

    ---Creates a menu separator in the given menu group, useful to separate several [Plugin:newCommand](lua://Plugin#pluginnewcommand).
    ---@param options {
    ---    group: string,
    ---}
    newMenuSeparator = function (self, options) end,
}

---@class Point
local _point = {
    ---@type integer
    x = nil,

    ---@type integer
    y = nil,
}

---Creates a new `Point` instance with the given coordinates (or `x=y=0` if they are not specified).
---@return Point
---@overload fun(otherPoint: Point): Point
---@overload fun(x: integer, y: integer)
---@overload fun(options: { x: integer, y: integer }): Point
---@overload fun(numbers: { [1]: integer, [2]: integer }): Point
function Point () end

---This class is used to represent the range of selected objects. It can be: A list of layers, A list of frames, A list of cels, A list of images, A list of colors, A list of slices. Or a combination of those.
---@class Range
local _range = {
    ---Returns a [RangeType](lua://RangeType#rangetype).
    ---@type RangeType
    type = nil,

    ---Returns true if the range is empty, i.e. there is no selected range in the timeline (a thick border in the timeline), only the [active cel](lua://app#appcel) in the sprite editor. This is the same as asking for `app.range.type == RangeType.EMPTY`. Note that if the range is empty, you can still use [Range.layers](lua://Range#rangelayers) to get the [active layer](lua://app#applayer) (the Range.layers property will be an array of one element, just the active layer). The same is true for [Range.frame](lua://Range#rangeframes) and [app.frame](lua://app#appframe), [Range.cel](lua://Range#rangecels) and [app.cel](lua://app#appcel), etc.
    ---@type boolean
    isEmpty = nil,

    ---[Sprite](lua://Sprite#sprite) to which this range is pointing to.
    ---@type Sprite
    sprite = nil,

    ---Returns or sets the array of selected [layers](lua://Layer#layer).
    ---@type Layer[]
    layers = nil,

    ---Returns or sets the array of selected [frames](lua://Frame#frame).
    ---@type Frame[]
    frames = nil,

    ---Returns an array of selected [cels](lua://Cel#cel).
    ---@type Cel[]
    cels = nil,

    ---Returns an array of selected [images](lua://Image#image) (images from linked cels are counted just one time in this array).
    ---@type Image[]
    images = nil,

    ---Returns an array of selected [images](lua://Image#image) in the range that are in unlocked layers (editable).
    ---@type Image[]
    editableImages = nil,

    ---Gets or sets the array of selected palette entries in the [color bar](https://www.aseprite.org/docs/color-bar/). Each element of the array is an integer (the palette index)
    ---@type integer[]
    colors = nil,

    ---Gets or sets the array of selected tile entries in the [color bar](https://www.aseprite.org/docs/color-bar/) when we are in a [tilemap layer](https://www.aseprite.org/docs/tilemap/). Each element of the array is an integer (the tile index).
    ---@type integer[]
    tiles = nil,

    ---Gets or sets the array of [selected slices](https://www.aseprite.org/docs/slices) in the sprite editor. Each element of the array is a [slice](lua://Slice#slice).
    ---@type Slice[]
    slices = nil,

    ---Returns true if the given object ([layer](lua://Layer#layer)/[frame](lua://Frame#frame)/[cel](lua://Cel#cel)/[slice](lua://Slice#slice)) is inside the selected range.
    ---@param object Layer | Frame | Cel | Slice
    ---@return boolean
    contains = function (self, object) end,

    ---Returns true if the given color index is selected in the [color bar](https://www.aseprite.org/docs/color-bar/).
    ---@param colorIndex integer
    ---@return boolean
    containsColor = function (self, colorIndex) end,

    ---Clears the current selected range of frames/layers/cels/colors.
    clear = function (self) end,
}

---Type of [range](lua://Range#rangetype) selected in the timeline.
---@class RangeType
RangeType = {
    ---When there is no selection.
    ---@type RangeType
    EMPTY = nil,

    ---When the selection is in the layers.
    ---@type RangeType
    LAYERS = nil,

    ---When the selection is in the frames.
    ---@type RangeType
    FRAMES = nil,

    ---When the selection is in the cels.
    ---@type RangeType
    CELS = nil,
}

---@class Rectangle
local _rectangle = {
    ---@type integer
    x = nil,

    ---@type integer
    y = nil,

    ---@type integer
    width = nil,

    ---@type integer
    height = nil,

    ---@type integer
    w = nil,

    ---@type integer
    h = nil,

    ---@type Point
    origin = nil,

    ---@type Size
    size = nil,

    ---@type boolean
    isEmpty = nil,

    ---@param otherRectangle Rectangle
    ---@return boolean
    contains = function (self, otherRectangle) end,

    ---@param otherRectangle Rectangle
    ---@return boolean
    intersects = function (self, otherRectangle) end,

    ---@param otherRectangle Rectangle
    ---@return Rectangle
    intersect = function (self, otherRectangle) end,

    ---@param otherRectangle Rectangle
    ---@return Rectangle
    union = function (self, otherRectangle) end,
}

---@return Rectangle
---@overload fun(otherRectangle: Rectangle): Rectangle
---@overload fun(x: integer, y: integer, width: integer, height: integer): Rectangle
---@overload fun(options: { x: integer, y: integer, width: integer, height: integer }): Rectangle
---@overload fun(options: { x: integer, y: integer, w: integer, h: integer }): Rectangle
---@overload fun(numbers: { [1]: integer, [2]: integer, [3]: integer, [4]: integer })
function Rectangle () end

---@class Selection
local _selection = {
    ---Returns a [rectangle](lua://Rectangle#rectangle) with the bounds of the selection (if the rectangle is empty, is because there is no selection).
    ---@type Rectangle
    bounds = nil,

    ---Gets or sets the selection origin/position (a [point](lua://Point#point)). This can be used to move the selection edges (not the content).
    ---@type Point
    origin = nil,

    ---Returns true if the selection is empty i.e. there are no pixels selected.
    ---@type boolean
    isEmpty = nil,

    deselect = function (self) end,

    ---Replaces the selection with the given [rectangle](lua://Rectangle#rectangle). If you want to add a rectangle to the selection, you can use [Selection:add()](lua://Selection#selectionadd).
    ---@param rectangle Rectangle
    select = function (self, rectangle) end,

    ---Selected the whole sprite canvas. Only valid for a [sprite.selection](lua://Sprite#spriteselection).
    selectAll = function (self) end,

    ---Adds a new rectangle (or `otherSelection`) to the `selection`. Creating an union between the existent selected area and the given `rectangle`/`otherSelection`.
    ---@param rectangle Rectangle
    ---@overload fun(self, otherSelection: Selection)
    add = function (self, rectangle) end,

    ---Subtracts the given `rectangle` (or `otherSelection`) from `selection`.
    ---@param rectangle Rectangle
    ---@overload fun(self, otherSelection: Selection)
    subtract = function (self, rectangle) end,

    ---Creates an intersection in `selection` between the given `rectangle` (or `otherSelection`) and the already selected area in `selection`.
    ---@param rectangle Rectangle
    ---@overload fun(self, otherSelection: Selection)
    intersect = function (self, rectangle) end,

    ---Returns true or false if the given [point](lua://Point#point) is inside the selection.
    ---@param point Point
    ---@return boolean
    ---@overload fun(self, x: integer, y: integer)
    contains = function (self, point) end,
}

---Creates a new empty selection, or with the given [rectangle](lua://Rectangle#rectangle).
---@param rectangle? Rectangle
---@return Selection
function Selection (rectangle) end

---@class SelectionMode
SelectionMode = {
    ---@type SelectionMode
    REPLACE = nil,

    ---@type SelectionMode
    ADD = nil,

    ---@type SelectionMode
    SUBTRACT = nil,

    ---@type SelectionMode
    INTERSECT = nil,
}

---This is an object that saves the active state of the editor in a specific moment. Which active sprite, layer, frame, cel, image, etc. were in a specific moment. If you save the object: `local site = app.site` The `site` object will not be updated if the active sprite is modified.
---@class Site
local _site = {
    ---Gets the [active sprite](lua://app#appsprite) at the time the site object was created.
    ---@type Sprite
    sprite = nil,

    ---Gets the [active layer](lua://app#applayer) at the time the site object was created.
    ---@type Layer
    layer = nil,

    ---Gets the [active cel](lua://app#appcel) at the time the site object was created.
    ---@type Cel
    cel = nil,

    ---Gets the [active frame](lua://app#appframe) at the time the site object was created.
    ---@type Frame
    frame = nil,

    ---Gets the active frame number (an integer value, 1 is the first frame). Same as [app.site.frame.frameNumber](lua://Site#siteframe).
    ---@type integer
    frameNumber = nil,

    ---Gets the [active image](lua://app#appimage) at the time the site object was created.
    ---@type Image
    image = nil,

    ---Gets [TilemapMode](lua://TilemapMode#tilemapmode). On non-tilemap layers, this field returns 0.
    ---@type TilemapMode | 0
    tilemapMode = nil,

    ---Gets [TilesetMode](lua://TilesetMode#tilesetmode). On non-tilemap layers, this field returns 0.
    ---@type TilesetMode | 0
    tilesetMode = nil,
}

---@class Size
local _size = {
    ---@type integer
    width = nil,

    ---@type integer
    height = nil,

    ---Same as [Size.width](lua://Size#sizewidth).
    ---@type integer
    w = nil,

    ---Same as [Size.height](lua://Size#sizeheight).
    ---@type integer
    h = nil,

    ---Returns the new size `newSize` which will be big enough to contains both given dimensions (`size` and `otherSize`).
    ---@param otherSize Size
    ---@return Size
    union = function (self, otherSize) end,
}

---Creates a new `Size` instance with the given dimensions (or `width=height=0` if they are not specified).
---@return Size
---@overload fun(otherSize: Size): Size
---@overload fun(width: integer, height: integer): Size
---@overload fun(options: { width: integer, height: integer }): Size
---@overload fun(options: { w: integer, h: integer }): Size
---@overload fun(numbers: { [1]: integer, [2]: integer }): Size
function Size () end

---An object that allows for [nine-slice scaling](https://en.wikipedia.org/wiki/9-slice_scaling). It can be created with the slice tool or with [Sprite:newSlice](lua://Sprite#spritenewslice).
---@class Slice
local _slice = {
    ---Gets or sets a slice's bounding [rectangle](lua://Rectangle#rectangle).
    ---@type Rectangle
    bounds = nil,

    ---Gets or sets the central [rectangle](lua://Rectangle#rectangle) of a slice's nine-slice. The getter returns `nil` when nine-slicing is inactive in Aseprite's user interface. The rectangle's top-left corner is defined in local coordinates.
    ---@type Rectangle | nil
    center = nil,

    ---Gets or sets the user-defined [color](lua://Color#color) of this slice in the timeline.
    ---@type Color
    color = nil,

    ---Gets or sets the user-defined data related to this slice, a `string`.
    ---@type string
    data = nil,

    ---Access user-defined and extension-defined [properties](lua://Properties#properties) of this slice.
    ---@type table<string, any>
    ---@overload fun(pluginKey: string): table<string, any>
    properties = nil,

    ---Gets or sets the a slice's name, a `string`.
    ---@type string
    name = nil,

    ---Gets or sets the slice's pivot, a [point](lua://Point#point). The getter returns `nil` when the pivot is inactive in Aseprite's user interface. The pivot is defined in local coordinates relative to the slice's top-left corner.
    ---@type Point | nil
    pivot = nil,

    ---Gets the [sprite](lua://Sprite#sprite) to which a slice belongs.
    ---@type Sprite
    sprite = nil,
}

---@class Sprite
local _sprite = {
    ---@type integer
    width = nil,

    ---@type integer
    height = nil,

    ---@type Rectangle
    bounds = nil,

    ---@type Rectangle
    gridBounds = nil,

    ---@type Size
    pixelRatio = nil,

    ---@type Selection
    selection = nil,

    ---@type string
    filename = nil,

    ---@type integer
    id = nil,

    ---@type boolean
    isModifier = nil,

    ---@type ColorSpace
    colorSpace = nil,

    ---@type ColorMode
    colorMode = nil,

    ---@type ImageSpec
    spec = nil,

    undoHistory = {
        ---@type integer
        undoSteps = nil,

        ---@type integer
        redoSteps = nil,
    },

    ---@type Frame[]
    frames = nil,

    ---@type Palette[]
    palettes = nil,

    ---@type Layer[]
    layers = nil,

    ---@type Cel[]
    cels = nil,

    ---@type Tag[]
    tags = nil,

    ---@type Slice[]
    slices = nil,

    ---@type Tileset[]
    tilesets = nil,

    ---@type Layer | nil
    backgroundLayer = nil,

    ---@type integer
    transparentColor = nil,

    ---@type Color
    color = nil,

    ---@type string
    data = nil,

    ---@type table<string, any>
    ---@overload fun(pluginKey: string): table<string, any>
    properties = nil,

    ---@param width integer
    ---@param height integer
    ---@overload fun(self, size: Size)
    resize = function (self, width, height) end,

    ---@param x integer
    ---@param y integer
    ---@param width integer
    ---@param height integer
    ---@overload fun(self, rectangle: Rectangle)
    crop = function (self, x, y, width, height) end,

    ---@param filename string
    saveAs = function (self, filename) end,

    ---@param filename string
    saveCopyAs = function (self, filename) end,

    close = function (self) end,

    ---@param filename string
    loadPalette = function (self, filename) end,

    ---@param palette Palette
    setPalette = function (self, palette) end,

    ---@param colorSpace ColorSpace
    assignColorSpace = function (self, colorSpace) end,

    ---@param colorSpace ColorSpace
    convertColorSpace = function (self, colorSpace) end,

    ---@return Layer
    newLayer = function (self) end,

    ---@return Layer
    newGroup = function (self) end,

    ---@param layerName string
    ---@overload fun(self, layer: Layer)
    deleteLayer = function (self, layerName) end,

    ---@param frame Frame
    ---@return Frame
    ---@overload fun(self, frameNumber: integer)
    newFrame = function (self, frame) end,

    ---@param frameNumber integer
    ---@return Frame
    newEmptyFrame = function (self, frameNumber) end,

    ---@param frame Frame
    deleteFrame = function (self, frame) end,

    ---@param layer Layer
    ---@param frame Frame
    ---@return Cel
    ---@overload fun(self, layer: Layer, frame: Frame, image: Image, position: Point)
    newCel = function (self, layer, frame) end,

    ---@param cel Cel
    ---@overload fun(self, layer: Layer, frame: Frame)
    deleteCel = function (self, cel) end,

    ---@param fromFrameNumber integer
    ---@param toFrameNumber integer
    ---@return Tag
    newTag = function (self, fromFrameNumber, toFrameNumber) end,

    ---@param tag Tag
    ---@overload fun(self, tagName: string)
    deleteTag = function (self, tag) end,

    ---@return Slice
    ---@overload fun(self, rectangle: Rectangle): Slice
    newSlice = function (self) end,

    ---@param slice Slice
    ---@overload fun(self, sliceName: string)
    deleteSlice = function (self, slice) end,

    ---@return Tileset
    ---@overload fun (grid: Grid): Tileset
    ---@overload fun (rectangle: Rectangle): Tileset
    ---@overload fun (grid: Grid, numTiles: integer): Tileset
    ---@overload fun (rectangle: Rectangle, numTiles: integer): Tileset
    ---@overload fun (anotherTileset: Tileset): Tileset
    newTileset = function (self) end,

    ---@param tileset Tileset
    ---@overload fun(self, tilesetIndex: integer)
    deleteTileset = function (self, tileset) end,

    ---@param tileset Tileset
    ---@overload fun (tileset: Tileset, tilesetIndex: integer)
    newTile = function (self, tileset) end,

    ---@param tile Tile
    ---@overload fun(self, tileset: Tileset, tileIndex: integer)
    deleteTile = function (self, tile) end,

    flatten = function (self) end,

    ---@type Events
    events = nil,

    ---@type string
    tileManagementPlugin = nil,
}

---@param width integer
---@param height integer
---@return Sprite
---@overload fun(width: integer, height: integer, colorMode: ColorMode): Sprite
---@overload fun(spec: ImageSpec): Sprite
---@overload fun (otherSprite: Sprite): Sprite
---@overload fun(options: { fromFile: string }): Sprite
---@overload fun(options: { fromFile: string, oneFrame: boolean }): Sprite
function Sprite (width, height) end

---Data format used to export JSON files in [app.command.ExportSpriteSheet](lua://command/ExportSpriteSheet#exportspritesheet).
---@class SpriteSheetDataFormat
SpriteSheetDataFormat = {
    ---@type SpriteSheetDataFormat
    JSON_HASH = nil,

    ---@type SpriteSheetDataFormat
    JSON_ARRAY = nil,
}

---Type of sprite sheet used in [app.command.ExportSpriteSheet](lua://command/ExportSpriteSheet#exportspritesheet).
---@class SpriteSheetType
SpriteSheetType = {
    ---@type SpriteSheetType
    HORIZONTAL = nil,

    ---@type SpriteSheetType
    VERTICAL = nil,

    ---@type SpriteSheetType
    ROWS = nil,

    ---@type SpriteSheetType
    COLUMNS = nil,

    ---@type SpriteSheetType
    PACKED = nil,
}

---Represents [a tag in the timeline](https://www.aseprite.org/docs/tags/).
---@class Tag
local _tag = {
    ---Returns the sprite to which this tag belongs.
    ---@type Sprite
    sprite = nil,

    ---Returns the first [Frame](lua://Frame#frame) object where this tag starts. Note: Old versions (Aseprite v1.2.10-beta2) returned a frame number instead of a `Frame` object.
    ---@type Frame
    fromFrame = nil,

    ---Returns the last [Frame](lua://Frame#frame) object where this tag ends. Note: Old versions (Aseprite v1.2.10-beta2) returned a frame number instead of a `Frame` object.
    ---@type Frame
    toFrame = nil,

    ---Returns the number of frames that this tag contain. Equal to: `local frames = tag.toFrame.frameNumber - tag.fromFrame.frameNumber + 1`
    ---@type integer
    frames = nil,

    ---Gets or sets the name of the tag (a string).
    ---@type string
    name = nil,

    ---Gets or sets the *[Animation Direction](https://www.aseprite.org/docs/tags/)* property of the tag.
    ---@type AniDir
    aniDir = nil,

    ---Gets or sets the user-defined [color](lua://Color#color) of this tag in the timeline.
    ---@type Color
    color = nil,

    ---Gets or sets the number of times the tag is repeated/looped. `0` = Doesn't specify, plays infinite in UI, once on export, for ping-pong it plays once in each direction. `1` = Plays once, for ping-pong it plays just in one direction. `2` = Plays twice, for ping-pong it plays once in each direction, and once in reverse. `n` = Plays N times
    ---@type integer
    repeats = nil,

    ---Gets or sets the user-defined data related to this tag, a `string`.
    ---@type string
    data = nil,

    ---Access user-defined and extension-defined [properties](lua://Properties#properties) of this tag.
    ---@type table<string, any>
    ---@overload fun(pluginKey: string): table<string, any>
    properties = nil,
}

---Access information about the current theme.
--- @class Theme
local _theme = {
    ---The [color](lua://Color) can be used to paint in an [Image](lua://Image) or a [GraphicsContext](lua://GraphicsContext).
    ---@type table<string, Color>
    color = nil,

    ---Returns a number identified in the dimensions of the theme.
    ---@type table<string, integer>
    dimension = nil,

    ---Returns information about the given style ID (`style_id` must be a string). The returned information at the moment includes a `border` field which is a table with `left`/`top`/`right`/`bottom` border dimension in pixels (they already have [app.uiScale](lua://app.uiScale) applied).
    ---@param style_id string
    ---@return any
    styleMetrics = function (style_id) end,
}

---Represents a tile from a [Tileset](lua://Tileset#tileset).
---@class Tile
local _tile = {
    ---The index of the tile (position in its [tileset](lua://Tileset#tileset)).
    ---@type integer
    index = nil,

    ---Gets or sets the [image](lua://Image#image) of this tile.
    ---@type Image
    image = nil,

    ---Gets or sets the user-defined [color](lua://Color#color) of this tile.
    ---@type Color
    color = nil,

    ---Gets or sets the user-defined data related to this tile (a text string).
    ---@type string
    data = nil,

    ---Access user-defined and extension-defined [properties](lua://Properties#properties) of this tile.
    ---@type table<string, any>
    ---@overload fun(pluginKey: string): table<string, any>
    properties = nil,
}

---@class TilemapMode
TilemapMode = {
    ---@type TilemapMode
    PIXELS = nil,

    ---@type TilemapMode
    TILES = nil,
}

---A set of [tiles](lua://Tile#tile).
---@class Tileset
local _tileset = {
    ---Gets or sets the name of this tileset.
    ---@type string
    name = nil,

    ---Gets or sets the base index of this tileset.
    ---@type integer
    baseIndex = nil,

    ---@type Color
    color = nil,

    ---Gets or sets the user-defined data related to this tileset (a text string).
    ---@type string
    data = nil,

    ---Access user-defined and extension-defined [properties](lua://Properties#properties) of this tileset.
    ---@type table<string, any>
    ---@overload fun(pluginKey: string): table<string, any>
    properties = nil,

    ---Returns the [grid](lua://Grid#grid) of this tileset.
    ---@type Grid
    grid = nil,

    ---Returns the [tile](lua://Tile#tile) in the given index (`0` is the empty tile, so `1` is the first user-defined tile).
    ---@param index integer
    ---@return Tile
    tile = function (self, index) end,

    ---Returns the image of tile in the given index (`0` is the empty tile, so `1` is the first user-defined tile). Note: This method was superseded with [Tileset:tile()](lua://Tileset#tilesettile), so you can use the following alternative: `local tileImage = ts:tile(index).image`
    ---@deprecated
    ---@param index integer
    ---@return Image
    getTile = function (self, index) end,
}

---@class TilesetMode
TilesetMode = {
    ---@type TilesetMode
    MANUAL = nil,

    ---@type TilesetMode
    AUTO = nil,

    ---@type TilesetMode
    STACK = nil,
}

---The Timer class can be used to execute a function periodically.
---@class Timer
local _timer = {
    ---Starts the timer.
    start = function (self) end,

    ---Stops the timer.
    stop = function (self) end,

    ---Returns the interval of this specific timer (in seconds).
    ---@type number
    interval = nil,

    ---Returns true if the timer is running.
    ---@type boolean
    isRunning = nil,
}

---Creates a new timer. `interval`: Number of seconds to wait for the first/next call. You can specify decimal numbers, e.g. `interval=1.0 / 60.0` to call the function 60 times per second, etc. `ontick`: Function that is called each time the specified number of seconds ellapses.
---@param init { interval: number, ontick: fun() }
---@return Timer
function Timer (init) end

---References a drawing tool. At the moment this class is used only to get and set the active tool ([app.tool](lua://app.tool)), or to paint on the canvas (`tool` parameter in [app.useTool()](lua://app.useTool)). If a function receives a tool, it can receive a tool ID too.
---@class Tool
local _tool = {
    ---Returns the identifier (a string) of the specified in the [gui.xml](https://github.com/aseprite/aseprite/blob/main/data/gui.xml) file ([example](https://github.com/aseprite/aseprite/blob/20618ff321ae4e73a4f5d6bfd9ef6f2cd8925b7a/data/gui.xml#L1065)).
    ---@type string
    id = nil,
}

---This object is received as first parameter in the function associated to `ontouch` event of a [canvas](lua://Dialog.canvas) widget.
---@class TouchEvent
local _touchEvent = {
    ---The (x,y) position of the touch when the event happens, in client coordinates, where (0,0) is the top-left corner of the canvas widget.
    ---@type integer
    x = nil,

    ---The (x,y) position of the touch when the event happens, in client coordinates, where (0,0) is the top-left corner of the canvas widget.
    ---@type integer
    y = nil,

    ---Magnification factor to apply.
    ---@type number
    magnification = nil,
}

---Represents an UUID (*Universally Unique IDentifier*), a 16-bytes unique identifier.
---
---You can compare UUIDs, convert them to a string of the `"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"` 36-chars format, or get each of byte using the `__index` Lua operator.
---@class Uuid: { [integer]: string }
local _uuid = {}

---You can create a new random UUID using `Uuid()` or a UUID representation of the given 36-chars string.
---@return Uuid
---@overload fun(fromString: string): Uuid
function Uuid () end

---Represents a version number and provides an easy way to compare if the [`app.version`](lua://App.version) is greater or equal than a specific expected version.
---@class Version
local _version = {
    ---Returns the first number of the version.
    ---@type integer
    major = nil,

    ---Returns the second number of the version.
    ---@type integer
    minor = nil,

    ---Returns the third number of the version.
    ---@type integer
    patch = nil,

    ---Returns the pre-release label/keyword. For official releases it's an empty string, in other cases it might be `"alpha"`, `"beta"`, `"dev"`, etc.
    ---@type string
    prereleaseLabel = nil,

    ---Returns the pre-release version.
    ---@type integer
    prereleaseNumber = nil,
}

---You can create a new version from a string. Then access each field
---@param versionString string
---@return Version
function Version (versionString) end

---@class WebSocket
local _websocket = {
    ---Address of the server. Read-only, the url is specified when creating the websocket.
    ---@type string
    url = nil,

    ---Try connecting to the server. After a successful connection, `onreceive` function will be called with message type `WebSocketMessageType.OPEN`. When the server or network breaks the connection, the client tries reconnecting automatically.
    connect = function (self) end,

    ---Disconnects from the server. After a disconnect, `onreceive` function will be called with message type `WebSocketMessageType.CLOSE`.
    close = function (self) end,

    ---Sends a text message to the server. If multiple strings are passed, they will be joined together.
    ---@param ... string
    sendText = function (self, ...) end,

    ---Sends a binary message to the server. If multiple strings are passed, they will be joined together. Lua makes no distinction between character and byte strings, but the websocket protocol does label them.
    ---@param ... string
    sendBinary = function (self, ...) end,

    ---Sends a very short ping message to the server. There's a limit to the length of data that can be sent. It's sometimes used to prevent the connection from timing out and closing. A standard compliant server will reply to every "ping" message with a "pong". Client pongs are sent automatically, and there's no need to control that.
    ---@param str string
    sendPing = function (self, str) end,
}

---Creates a websocket client that can be used to communicate with another program:
---
---* `url` specifies the server to connect.
---* `deflate` option enables compression before sending the data - if the server is running on the same machine, it might be faster to turn it off.
---* `onreceive` function will be called for every incoming message, and when the connection is established and broken. Its two arguments are the event type (see [`WebSocketMessageType`](lua://WebSocketMessageType)) and the received data (a string, can be empty).
---* `minreconnectwait` and `maxreconnectwait` (in seconds) are optional values that limit the waiting time to try a reconnection to the server.
---@return WebSocket
---@overload fun(
---    url: string,
---    onreceive: fun(message: string, data: any),
---    deflate: boolean,
---    minreconnectwait: integer,
---    maxreconnectwait: integer,
---)
function WebSocket () end

---@class WebSocketMessageType
WebSocketMessageType = {
    ---Text message received
    ---@type WebSocketMessageType
    TEXT = nil,

    ---Binary message received
    ---@type WebSocketMessageType
    BINARY = nil,

    ---Connected to the server
    ---@type WebSocketMessageType
    OPEN = nil,

    ---Connection was closed for any reason, or broke
    ---@type WebSocketMessageType
    CLOSE = nil,

    ---See [the standard](https://datatracker.ietf.org/doc/html/rfc6455) about ping and pong.
    ---@type WebSocketMessageType
    PING = nil,

    ---Your ping has been answered.
    ---
    ---Note that incoming pings are answered automatically.
    ---@type WebSocketMessageType
    PONG = nil,

    ---@type WebSocketMessageType
    FRAGMENT = nil,
}

---References a window of the program. At the moment we can access only the main window using [app.window](lua://App.window).
---@class Window
local _window = {
    ---Returns the width of the main window.
    ---@type integer
    width = nil,

    ---Returns the height of the main window.
    ---@type integer
    height = nil,

    ---Returns the [`Events`](lua://Events) object to associate functions that can act like listeners of specific `Window` events.
    ---
    ---Available events for a `Window`:
    ---
    ---* `'resize'`: When the user resizes the window.
    ---@type Events
    events = nil,
}
