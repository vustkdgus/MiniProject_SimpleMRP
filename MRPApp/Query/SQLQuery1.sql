-- PrcResult���� ���������� ���а����� �ٸ� �÷�
SELECT p.SchIdx, p.PrcDate, 
		CASE p.PrcResult WHEN 1 THEN 1 ELSE 0 END AS PrcOK,
		CASE p.prcResult when 0 THEN 1 ELSE 0 END AS PrcFail
	FROM Process AS p


-- 2. �հ����� ��� ������̺�

SELECT smr.SchIdx, smr.PrcDate, SUM(smr.prcOK) as PrcOKAmount, SUM(smr.prcFail) as PrcFailAmount
	FROM (
		SELECT p.SchIdx, p.PrcDate, 
			CASE p.PrcResult WHEN 1 THEN 1 ELSE 0 END AS PrcOK,
			CASE p.prcResult when 0 THEN 1 ELSE 0 END AS PrcFail
		FROM Process AS p
		 ) AS smr
GROUP BY smr.SchIdx, smr.PrcDate

--3.0 ���ι�
SELECT * 
	FROM Schedules AS sch 
   INNER JOIN Process AS prc
	ON sch.SchIdx = prc.SchIdx


--3.1 2�����(�������̺�)�� Schedules ���̺� �����ؼ� ���ϴ� ��� ����
SELECT sch.SchIdx, sch.PlantCode, sch.SchAmount, prc.PrcDate,
		prc.prcOKAmount, prcFailAmount
	FROM Schedules AS sch
	INNER JOIN (
	SELECT smr.SchIdx, smr.PrcDate, SUM(smr.prcOK) as PrcOKAmount, SUM(smr.prcFail) as PrcFailAmount
	FROM (
		SELECT p.SchIdx, p.PrcDate, 
			CASE p.PrcResult WHEN 1 THEN 1 ELSE 0 END AS PrcOK,
			CASE p.prcResult when 0 THEN 1 ELSE 0 END AS PrcFail
		FROM Process AS p
		 ) AS smr
		GROUP BY smr.SchIdx, smr.PrcDate
	) AS prc
	ON sch.SchIdx = prc.SchIdx