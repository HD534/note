###去除空行
https://stackoverflow.com/questions/12453160/remove-empty-lines-in-text-using-visual-studio

Since Visual Studio 2012 changed its regex syntax.

#### Remove single blank lines
Old:
`^:b*$\n`
New:
`^(?([^\r\n])\s)*\r?$\r?\n`

Visual Studio 2013
`^\s*$\n`

####Remove double blank lines
Old:
`^:b*\n:b*\n`
New:
`^(?([^\r\n])\s)*\r?\n(?([^\r\n])\s)*\r?\n`

more reference
https://docs.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2012/2k3te2cs(v=vs.110)?redirectedfrom=MSDN