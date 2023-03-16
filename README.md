# 프로젝트명
NEWSIC(음원NFT 펀딩 플렛폼) / 기업협약프로젝트


## 배포 링크
http://ceo7913.github.io/NEWSIC-Project-Front/

## 프로젝트 멤버
윤하영(BACK/CONTRACT), 이지니(FRONT), 임준우(FRONT), 김경환(BACK/CONTRACT)

## 사용한 스택
<h4>- FRONT</h4>
<span>
<img src="https://img.shields.io/badge/react-61DAFB?style=for-the-badge&logo=react&logoColor=black">
<img src="https://img.shields.io/badge/redux-764ABC?style=for-the-badge&logo=redux&logoColor=white">
<img src="https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=next.js&logoColor=white">
<img src="https://img.shields.io/badge/FRAMER-007396?style=for-the-badge&logo=Framer&logoColor=white">
<img src="https://img.shields.io/badge/sass-CC6699?style=for-the-badge&logo=sass&logoColor=white"></span>

<h4>- BACK</h4>
<span>
<img src="https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=TypeScript&logoColor=white">
<img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
<img src="https://img.shields.io/badge/nestjs-E0234E?style=for-the-badge&logo=nestjs&logoColor=white">
<img src="https://img.shields.io/badge/prisma-2D3748?style=for-the-badge&logo=prisma&logoColor=white"></span>

<h4>- BLOCKCHAIN</h4>
<span>
<img src="https://img.shields.io/badge/Solidity-363636?style=for-the-badge&logo=Solidity&logoColor=white">
<img src="https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white">

<h4>- ETC</h4>
<span>
<img src="https://img.shields.io/badge/AmazonAWS-FF9900?style=for-the-badge&logo=AmazonAWS&logoColor=white">
<img src="https://img.shields.io/badge/Metamask-E57000?style=for-the-badge&logo=&logoColor=white">
</span>

## 프로젝트 정보
- 프로젝트 상세 구성
  - 구축 플랫폼
    > 음원 NFT를 지분화 하여 펀딩 가능
    
    > 펀딩완료 후 호가 형태의 거래 가능
    
    > 구독권 구매 및 음악 스트리밍 이용 가능
    
  - 기능 부분
    > 회원관리 및 마이페이지
    
    > 일반 음원 감상 및 펀딩 음원 거래
    
    > NFT 보유자에게 음원 재생 횟수에 따른 수익 분배
    
  - 페이지 구성 (Front)
 <img src="https://user-images.githubusercontent.com/106497516/225568363-6726343d-f410-4af8-973e-e48de62c7573.png" alt="pages-sample1">
<img src="https://user-images.githubusercontent.com/106497516/225568713-8026aa57-48f1-42fd-8707-73a2d1ba148e.png" alt="pages-sample2">   
       
- 상태관리로 MobX 가 아닌 Redux 를 사용한 이유?  
  > Redux 는 상태를 중앙 집중식으로 관리하기 때문에 컴포넌트 간 상태 전달에 대한 복잡성을 줄일 수 있기 때문에 React 와 함께 사용하기 좋은 라이브러리라고 판단했음

- figma 가 아닌 Framer 를 사용한 이유? 
  > 컴포넌트로 UI 를 나눌 수 있고 figma 보다 코드 친화적이기 때문에 Framer 를 사용함 또한 동작 라이르러리를 Framer-motion 을 사용했기 때문에 두 가지의 시너지가 더 발휘되기 좋았음
  
- Scss 를 사용한 이유?
  > @function 이나 @return 커스텀 함수의 활용이 가능하고, 프로젝트의 규모가 크기 때문에 선택자의 중첩(Nesting)을 통해 반복되는 선택자 사용을 줄이기 위해 사용함

- Next.js 를 사용한 이유? 
  > 굳이 React 가 있는데 Next.js 를 추가로 사용한 이유는 Server-Side Rendering(SSR)을 가능하게 하기 때문인데 페이지를 렌더링하는 시간을 단축시키고 웹사이트의 구조나 콘텐츠를 최적화 하기 위해서 이다.
