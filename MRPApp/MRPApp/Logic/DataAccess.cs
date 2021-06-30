using MRPApp.Model;
using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MRPApp.Logic
{
    public class DataAccess
    {
        // 셋팅테이블에서 데이터 가져오기
        public static List<Settings> GetSettings()
        {
            List<Model.Settings> settings;

            using (var ctx = new MRPIEntities())
                settings = ctx.Settings.ToList(); // SELECT

            return settings;
        }

        internal static int SetSettings(Settings item)
        {
            using (var ctx = new MRPIEntities())
            {
                ctx.Settings.AddOrUpdate(item);
                return ctx.SaveChanges(); // 데이터 커밋
            }

        }

        internal static int DelSettings(Settings item)
        {
            using (var ctx = new MRPIEntities())
            {
                var obj = ctx.Settings.Find(item.BasicCode);
                ctx.Settings.Remove(obj);
                return ctx.SaveChanges(); // 데이터 커밋
            }
        }

        internal static List<Schedules> GetSchedules()
        {
            List<Model.Schedules> list;

            using (var ctx = new MRPIEntities())
                list = ctx.Schedules.ToList(); // SELECT

            return list;
        }

        internal static int SetSchedule(Schedules item)
        {
            using (var ctx = new MRPIEntities())
            {
                ctx.Schedules.AddOrUpdate(item);
                return ctx.SaveChanges(); // 데이터 커밋
            }
        }

        internal static List<Process> GetProcesses()
        {
            List<Model.Process> list;

            using (var ctx = new MRPIEntities())
                list = ctx.Process.ToList(); // SELECT

            return list;
        }

        internal static int SetProcess(Process item)
        {
            using (var ctx = new MRPIEntities())
            {
                ctx.Process.AddOrUpdate(item); // INSERT | UPDATE
                return ctx.SaveChanges(); // 데이터 커밋
            }
        }
    }
}
