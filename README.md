# Blood-Pressure-Measurement-using-PPG
> PPG를 활용한 혈압 측정 데이터 분석

## Table of Contents
1. 목적
2. 분석 과정
3. 결과

## 1. 목적
- PPG 신호를 사용하여 혈압을 추정할 수 있는지 가능성을 확인
- PPG 신호만으로 혈압을 추정할 수 있다면 이를 비접촉으로 구현 가능함

## 2. 분석 과정
1. PPG에서 5가지 지표 추출
- STT (Slope Transit Time)=width/height
- Width
- Height
- HR = 60/rri
- Area
<img src="https://user-images.githubusercontent.com/54797864/230810159-d3bc4e38-0e1e-4dbb-8980-e942f6ae9c72.png" width=50%>

2. 혈압과의 상관분석 수행
    - STT, Width, Height 3가지 지표가 혈압과의 상관관계가 있다고 판단
<p align="center"><img src="https://user-images.githubusercontent.com/54797864/230810453-954f9fcb-6153-4954-a7ff-6c3dabf0ec93.png"></p>

3. 선형회귀
    - 3가지 지표와 추가적인 HR 지표의 조합을 통해 선형회귀 수행
    - Width+Height+HR 3가지 지표를 이용한 경우의 혈압값과 기준 혈압값의 ccorrelation이 가장 높음
    - DBP의 경우
    <img src="https://user-images.githubusercontent.com/54797864/230810667-5b4b0703-ec68-4875-a97f-ddc4f18bdba9.png" width=60%>
    
    - SBP의 경우
    
    <img src="https://user-images.githubusercontent.com/54797864/230810730-af9feabf-d9f8-4084-945c-640f2dfff6fa.png" width=60%>

4. Test
    - 3가지 지표를 모두 사용한 경우의 test 결과가 좋지 않음
    - Width, Height의 변동성을 원인으로 판단하여 그 비율인 STT 사용
    - 결과 correlation은 좋지 않지만 전보다 모델에 fitting
     <img src="https://user-images.githubusercontent.com/54797864/230810883-1ad790f5-1c82-44f3-bca5-822829f3affc.png" width=60%>
     
## 3. 결과
- Width와 Height 지표를 사용하여 학습한 것이 가장 성능이 좋지만 새로운 데이터에 적용하였을 때에도 좋은 지표는 STT 지표임
- PPG만으로도 혈압을 추정할 수 있고, PPG의 가장 큰 peak와 valley만 찾으면 혈압을 추정할 수 있기 때문에 remote PPG로도 혈압을 추정할 수 있다는 가능성을 보임
