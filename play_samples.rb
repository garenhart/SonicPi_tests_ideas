# PlaySamples.rb
# 6Dec2018
# Interate thru all the SonicPi sample groups and play each sample name
sg=sample_groups
i=0
k=0
m=0
www=[]
xxx=[]
while i<sg.length-2
  sn=sample_names(sg[i])
  snn=sn.reverse
  j=0
  while j<sn.length
    www.push(sn[j])
    xxx.push(snn[j])
    ##sample(sn[j])
    #sleep 0.25
    j+=1
  end
  i+=1
  if(i==5)
    i=11
  end
  if (i==13)
    i=12
    k+=1
    if(k>3)
      k=0
      i=0
    end
  end
end
i=0
j=0
puts www
ww=www.reverse
xx=xxx.reverse
while j<6
  while i< www.length
    puts i,j
    case j
    when 0
      sample(www[i])
    when 1
      sample(ww[i])
    when 2
      sample(xxx[i])
    when 3
      sample(xx[i])
    when 4
      sample(www[i])
      sample(xxx[i])
    when 5
      sample(www[i])
      sample(xxx[i])
      sample(ww[i])
      sample(xx[i])
      
    end
    
    sleep 0.25
    i+=1
  end
  j+=1
  i=0
  puts 'j=',j
end
puts "end of samples"