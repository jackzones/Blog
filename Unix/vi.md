######撤销上一步操作
`u`
######每行的第一个空格替换为'  -y '
每行的第一个空格替换为' -y '
`:%s/ / -y /`

######替换当前行第一个 vivian为sky 
`:s/vivian/sky/ `
######替换当前行所有 vivian为sky 
`:s/vivian/sky/g `
######替换第n行开始到最后一行中每一行的第一个   vivian 为 sky
`:n,$s/vivian/sky/`
######替换第 n 行开始到最后一行中每一行所有  vivian 为 sky
`:n,$s/vivian/sky/g`
######替换每一行的第一个 vivian 为 sky
`:%s/vivian/sky/`or 

`:g/vivian/s//sky/）`
######替换每一行中所有 vivian 为 sky
`:%s/vivian/sky/g`or 

`:g/vivian/s//sky/g`