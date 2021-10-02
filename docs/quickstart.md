# Quick Start

<!-- panels:start -->
<!-- div:left-panel -->

The absolute base to get started.

<!-- div:right-panel -->
<!-- tabs:start -->

#### **Haxe**

```haxe
import dropecho.langgen.Language;

class Main {
  static public function main():Void {
    var lang = new Language();
    trace(lang.createWord("city"));

    // outputs something like 'mimak'
  }
}
```

#### **JS**

```js
const { Language } = require('@dropecho/langgen');

var lang = new Language();
console.log(lang.createWord('city'));

// outputs something like 'mimak'
```

<!-- tabs:end -->

<!-- panels:end -->

<!-- panels:start -->
<!-- div:title-panel -->
