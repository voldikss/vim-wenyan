" Vim syntax file
" Language:    wenyan-lang

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syntax match wenyanKeywordModifier /\v吾有|今有|有/
syntax match wenyanKeywordType /\v數|列|言|術|爻/
syntax match wenyanKeywordControl /\v恆為是/
syntax match wenyanKeywordControl /\v若非|若|者|夫/
syntax match wenyanKeywordControl /\v乃得|乃歸空無|是謂|之術也|必先得|是術曰|乃行是術曰|欲行是術|也|云云|凡|中之|恆為是|為是|遍|乃止/
syntax match wenyanKeywordOperator /\v等於|不等於|不大於|不小於|大於|小於/
syntax match wenyanKeywordOperator /\v加|減|乘|除|中有陽乎|中無陰乎|變|所餘幾何|以|於|之長|之|充|銜|其餘/
syntax match wenyanKeywordOperator /\v昔之|今|是矣|其/
syntax match wenyanKeywordOther /\v書之|名之曰|施|曰|噫/

syntax match wenyanCommentLine /\v注曰|疏曰|批曰.*$/

syntax match wenyanConstantsNumeric /\v零|一|二|三|四|五|六|七|八|九|十|百|千|萬|億|兆|京|垓|秭|穣|溝|澗|正|載|極|恆河沙|阿僧祇|那由他|不可思議|無量大數|分|釐|毫|絲|忽|微|纖|沙|塵|埃|渺|漠|模糊|逡巡|須臾|瞬息|彈指|剎那|六德|虛|空|清|淨/
syntax match wenyanConstantsBool /\v陰|陽/

syntax match wenyanStringQuoted /\v(「「)(.*)(」」)/

syntax match wenyanPunctuationSeparator /\v。/

syntax match wenyanVariablesOther /\v.*/ contains=wenyanKeyword.*,wenyanCommentLine,wenyanConstants.*,wenyanPunctuationSeparator

hi def link wenyanKeywordModifier      Identifier
hi def link wenyanKeywordType          Type
hi def link wenyanKeywordControl       Conditional
hi def link wenyanKeywordOperator      Operator
hi def link wenyanKeywordOther         Keyword
hi def link wenyanCommentLine          Comment
hi def link wenyanConstantsNumeric     Number
hi def link wenyanConstantsBool        Boolean
hi def link wenyanStringQuoted         String
hi def link wenyanPunctuationSeparator Special
hi def link wenyanVariablesOther       Include

let b:current_syntax = "wenyan"

let &cpo = s:cpo_save
unlet s:cpo_save
