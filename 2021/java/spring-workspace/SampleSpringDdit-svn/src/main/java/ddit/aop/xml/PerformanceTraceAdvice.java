package ddit.aop.xml;

import org.aspectj.lang.ProceedingJoinPoint;

public class PerformanceTraceAdvice {
	public Object trace(ProceedingJoinPoint joinPoint) throws Throwable{
		//.Signature() : 메소드 정보 / .toShortString() : 문자열로 출력
		//타겟 메서드의 signature 정보를 가져옴
		String signatureString 
			= joinPoint.getSignature().toShortString();
		System.out.println(signatureString + " 시작");
		//타겟의 메서드가 호출되기 전의 시간
		long start = System.currentTimeMillis();
		try {
			//정지되어 있던 핵심 프로세스를 continue함
			//타겟(핵심 concern)의 메서드 호출
			Object result = joinPoint.proceed();
			return result;
		}finally {
			//타겟의 메서드가 호출된 후의 시간
			long finish = System.currentTimeMillis();
			System.out.println(signatureString + " 종료");
			System.out.println(signatureString + " 실행 시간 : " + 
					(finish - start) + " ms");
		}
		
		
	}
}



