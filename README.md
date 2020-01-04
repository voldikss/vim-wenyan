# vim-wenyan

Vim support for [wenyan-lang(文言文編程語言)](https://github.com/LingDong-/wenyan-lang)

### Installation

```vim
Plug 'voldikss/vim-wenyan'
```

### Features

- Auto dectect

Only load this plugin when edit wenyan script with extention `*.wy` or
`*.wenyan` or even `*.文言`.

- Syntax highlight

![](https://user-images.githubusercontent.com/20282795/71150014-2f61b900-226b-11ea-91f9-51b5b2d5ad3b.PNG)

- Snippets

![](https://user-images.githubusercontent.com/20282795/71150008-2e308c00-226b-11ea-88dc-249b9563e6cd.gif)

- Indent

![](https://user-images.githubusercontent.com/20282795/71150011-2ec92280-226b-11ea-8bb0-dc543dbaa841.gif)

- Buffer mappings

<img src="https://user-images.githubusercontent.com/20282795/71150009-2ec92280-226b-11ea-9e6c-2a5ef008cf35.gif" width=500>

- Directly running

The following command/mappings availalbe when editing wenyan file.

| map | command | argument | action |
| --- | ------- | -----    | ----  |
| `<F9>` | :Compile | js/py/rb | compile to target script and open |
| `<F5>` | :Run | js default only | directly run wenyan script |
| `<F6>` | :Render | render title | outpu to .svg file |
| `<S-F9>` | :Clean | js/py/rb/svg | clean some files |

### References

- [wenyan-lang](https://github.com/LingDong-/wenyan-lang)

- [wenyan-lang-vscode](https://github.com/antfu/wenyan-lang-vscode)
